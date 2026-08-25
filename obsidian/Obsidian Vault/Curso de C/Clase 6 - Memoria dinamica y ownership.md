# Clase 06 — Memoria Dinámica y Ownership

#c #memoria #heap #ownership #go-to-c

---

## Contexto — por qué esta clase importa

En Go, `append`, `make` y el GC manejan esto por ti. En C **tú eres el GC**. Sin este modelo mental, todo lo que construyas encima tiene cimientos frágiles.

---

## Las cuatro funciones

### `malloc`

```c
void *malloc(size_t size);
```

- Pide `size` bytes en el heap
- El contenido es **basura** — lo que había antes en esa memoria
- Retorna `NULL` si falla — **siempre verificar**

```c
int *arr = malloc(4 * sizeof(int));
if (arr == NULL) { /* manejar */ }
// arr[0..3] contienen basura — nunca asumir ceros
```

### `calloc`

```c
void *calloc(size_t count, size_t size);
```

- Equivale a `malloc(count * size)` pero **inicializa todo a cero**
- Más lento, elimina una clase entera de bugs

```c
int *arr = calloc(4, sizeof(int));
// arr[0..3] son 0 garantizado
```

> **Regla de decisión**: ¿Vas a escribir antes de leer? → `malloc`. ¿Necesitas garantía de ceros? → `calloc`.

### `realloc`

```c
void *realloc(void *ptr, size_t new_size);
```

|Situación|Qué hace|
|---|---|
|Hay espacio contiguo disponible|Extiende in-place, misma dirección|
|No hay espacio contiguo|Alloca nuevo, copia, libera el viejo|
|`new_size == 0`|Comportamiento definido por implementación — no usar|

**Caso especial:**

```c
realloc(NULL, size); // equivalente a malloc(size)
```

**Por qué devuelve `void *` y no modifica el puntero directamente**: porque puede mover el bloque a una dirección nueva. Si modificara el puntero original in-place, no habría forma de retornar el error sin corromper el estado.

#### Patrón correcto — nunca saltárselo

```c
// ❌ Bug clásico — buf apunta al bloque viejo/liberado
realloc(buf, new_size);

// ❌ Bug sutil — si falla, perdiste la única referencia → leak
buf = realloc(buf, new_size);

// ✅ Correcto
void *tmp = realloc(buf, new_size);
if (tmp == NULL) {
    // buf sigue válido, manejar el error
    return -1;
}
buf = tmp;
```

### `free`

```c
void free(void *ptr);
```

- Exactamente **una vez** por cada `malloc`/`calloc`/`realloc`
- Solo con punteros que vienen del heap
- `free(NULL)` es perfectamente válido — no hace nada (estándar lo garantiza)

> **Buena práctica**: después de `free`, igualar el puntero a `NULL` para que un doble-free falle rápido y predecible en lugar de silenciosamente.

---

## El modelo mental del grow

Cuando un buffer está lleno y el espacio contiguo está ocupado, la única salida es **mudarse**:

1. Pedir un bloque nuevo más grande en otro lugar
2. Copiar todos los datos del bloque viejo al nuevo
3. Liberar el bloque viejo

**Consecuencia crítica**: cualquier puntero que apuntaba al bloque original queda **inválido** después de este proceso.

Esto explica por qué `append` en Go _devuelve_ el slice — te obliga a actualizar tu referencia porque la dirección pudo haber cambiado. En C nadie te obliga. Tú eres responsable.

---

## Ownership — el contrato que C no impone

**Regla fundamental**: quien alloca, libera.

Hay tres contratos posibles — deben vivir en los comentarios:

```c
// CONTRATO 1: caller mantiene ownership
// La función lee pero no libera ni guarda el puntero
void print_name(const char *name);

// CONTRATO 2: la función toma ownership
// Después de llamarla, el caller NO debe usar ni liberar el puntero
void queue_push(Queue *q, char *data);  // q toma ownership de data

// CONTRATO 3: la función transfiere ownership al caller
// El caller es responsable de liberar lo que recibe
char *strdup_own(const char *s);  // caller debe llamar free()
```

> Cuando el ownership no está documentado, hay un bug esperando pasar.

---

## El patrón grow — dynamic array (Vec)

Lo que es un slice de Go por dentro:

### `vec.h`

```c
#ifndef VEC_H
#define VEC_H

typedef struct {
    int    *data;
    size_t  len;
    size_t  cap;
} Vec;

Vec  vec_create(void);
void vec_destroy(Vec *v);
int  vec_push(Vec *v, int value);         // 0 ok, -1 error
int  vec_get(const Vec *v, size_t i, int *out);
int  vec_swap_remove(Vec *v, size_t i);   // O(1), no preserva orden
int  vec_shrink_to_fit(Vec *v);

#endif
```

### `vec.c`

```c
#include <stdlib.h>
#include "vec.h"

#define VEC_INITIAL_CAP 4

Vec vec_create(void) {
    return (Vec){ .data = NULL, .len = 0, .cap = 0 };
}

void vec_destroy(Vec *v) {
    free(v->data);   // free(NULL) es válido — funciona aunque nunca se pusheó
    v->data = NULL;  // previene use-after-free
    v->len  = 0;
    v->cap  = 0;
}

int vec_push(Vec *v, int value) {
    if (v->len == v->cap) {
        size_t new_cap = v->cap == 0 ? VEC_INITIAL_CAP : v->cap * 2;
        int *tmp = realloc(v->data, new_cap * sizeof(int));
        if (tmp == NULL) {
            return -1;  // v->data sigue válido
        }
        v->data = tmp;
        v->cap  = new_cap;
    }
    v->data[v->len++] = value;
    return 0;
}

int vec_get(const Vec *v, size_t i, int *out) {
    if (i >= v->len) return -1;
    *out = v->data[i];
    return 0;
}

int vec_swap_remove(Vec *v, size_t i) {
    if (i >= v->len) return -1;
    v->data[i] = v->data[--v->len];
    return 0;
}

int vec_shrink_to_fit(Vec *v) {
    if (v->len == v->cap) return 0;  // ya está shrinkado — no es error
    if (v->len == 0)      return 0;  // realloc(ptr, 0) es impl-defined

    int *copy = realloc(v->data, sizeof(int) * v->len);
    if (copy == NULL) {
        return -1;  // v->data y v->cap siguen consistentes
    }
    v->data = copy;
    v->cap  = v->len;  // actualizar cap SOLO después de confirmar éxito
    return 0;
}
```

### Decisiones de diseño que notar

- `realloc(NULL, size)` == `malloc(size)` → el primer `vec_push` funciona sin caso especial porque `data` arranca en `NULL`
- Patrón `tmp = realloc(...)` — nunca `v->data = realloc(v->data, ...)` directamente
- `vec_destroy` anula todos los campos — fallo rápido y predecible si alguien usa el Vec después
- **No se encoge automáticamente** al hacer `swap_remove` — evita thrashing. Solo con `shrink_to_fit` explícito

### Sobre shrink — por qué no es automático

Si encoges agresivamente cada vez que `len` baja, y el caller vuelve a pushear, pagas `realloc` + copia dos veces para nada. La heurística estándar (que usa Go internamente) es no encoger automáticamente, o solo cuando `len < cap / 4`.

---

## Regla crítica al mutar estado

**No mutar estado hasta confirmar éxito.**

```c
// ❌ Mutas cap antes de saber si realloc funcionó
v->cap = v->len;
int *copy = realloc(v->data, sizeof(int) * v->cap);
if (copy == NULL) {
    return -1;  // cap y data son inconsistentes — estado corrupto
}

// ✅ Mutas cap solo cuando ya sabes que funcionó
int *copy = realloc(v->data, sizeof(int) * v->len);
if (copy == NULL) {
    return -1;  // v->data y v->cap siguen consistentes
}
v->data = copy;
v->cap  = v->len;
```

Este patrón aparece constantemente en código C robusto.

---

## Double free y use-after-free

Los dos bugs de memoria más comunes:

```c
int *p = malloc(sizeof(int));
*p = 42;
free(p);

int x = *p;  // USE-AFTER-FREE: leer memoria ya liberada
free(p);     // DOUBLE FREE: liberar dos veces
```

### Cómo leer el reporte de AddressSanitizer

```
READ of size 4 at 0x6020000000d0
    #0 in main bugs.c:9          ← dónde ocurrió el acceso inválido

freed by thread T0 here:
    #1 in main bugs.c:7          ← dónde se liberó

previously allocated by thread T0 here:
    #1 in main bugs.c:5          ← dónde se allocó
```

El sanitizer te da la historia completa: **allocaste en línea X, liberaste en línea Y, accediste inválidamente en línea Z**.

### Shadow bytes

El sanitizer mapea 8 bytes de tu memoria → 1 byte de shadow memory:

|Código|Significado|
|---|---|
|`00`|Addressable — memoria válida|
|`fd`|Freed heap region — tu bloque liberado|
|`fa`|Heap redzone — zona de guardia alrededor del bloque|
|`f1`–`f3`|Stack redzones|

Cuando haces `free`, marca los bytes como `fd`. Cuando intentas acceder, ve `fd` y aborta antes de que corrompas algo.

**Costo**: ~1/8 de memoria extra + overhead por acceso → solo en desarrollo, no en producción.

---

## Go ↔ C

|Go|C|
|---|---|
|`make([]T, len, cap)`|`malloc` / `calloc` + struct con `data`, `len`, `cap`|
|`append(s, x)` devuelve slice|`vec_push` recibe `Vec *` — tú actualizas|
|GC libera automáticamente|`free` — exactamente una vez, tú decides cuándo|
|`append` obliga a capturar retorno|`realloc` devuelve nuevo puntero — tú debes asignarlo|
|Shrink no es automático|Shrink no es automático — misma heurística|

---

## Checklist antes de mergear código con malloc

- [ ] ¿Verifico el retorno de `malloc`/`calloc`/`realloc` contra `NULL`?
- [ ] ¿Uso `tmp = realloc(...)` en lugar de `ptr = realloc(ptr, ...)`?
- [ ] ¿Cada `malloc` tiene exactamente un `free`?
- [ ] ¿El ownership está documentado en el `.h`?
- [ ] ¿Anulo punteros a `NULL` después de `free`?
- [ ] ¿Muto estado solo después de confirmar éxito de la operación?
- [ ] ¿Compilé con `-fsanitize=address,undefined` y no hay errores?