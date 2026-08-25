# Clase 2 — Punteros en C

**Fecha:** 2026-03-20
**Tags:** #c #sistemas #punteros #semana-2

---

## 1. ¿Por qué no un entero para guardar direcciones?

La intuición inicial es usar un `int` o `long` — una dirección es un número. Pero C tiene un tipo diseñado específicamente para esto.

```c
int x = 42;

// ❌ Intuitivo pero incorrecto
int  addr = &x;   // Warning: pointer to integer cast
long addr = &x;   // Funciona en 64-bit, pero es UB en otros contextos

// ✅ Correcto
int *p = &x;      // p es un "puntero a int"
```

**Razones concretas:**
- `sizeof(int)` = 4 bytes, `sizeof(int *)` = 8 bytes en 64-bit → truncas la dirección silenciosamente
- El compilador usa el tipo para aritmética correcta (`p + 1` suma `sizeof(int)`, no 1 byte)
- Type checking: `float *p = &int_var` falla en compilación

### `uintptr_t` — cuando sí necesitas un entero

```c
#include <stdint.h>
uintptr_t addr = (uintptr_t)&x;  // Portátil, explícito
```

Existe para logging, aritmética de bajo nivel. Es la excepción, no la regla.

---

## 2. Los tres operadores fundamentales

```c
int x  = 42;
int *p = &x;
```

| Expresión | Tipo   | Valor            | Descripción              |
|-----------|--------|------------------|--------------------------|
| `x`       | `int`  | `42`             | valor directo            |
| `&x`      | `int*` | dirección de x   | address-of               |
| `p`       | `int*` | dirección de x   | lo que guarda p          |
| `&p`      | `int**`| dirección de p   | address-of del puntero   |
| `*p`      | `int`  | `42`             | dereference — va y lee   |

### Dereference — `*p`

```c
*p = 100;       // escribe en la dirección que apunta p
printf("%d", x); // 100 — x cambió
```

`*p = 100` no toca `p`. `p` sigue apuntando al mismo lugar. Lo que cambió es el contenido de esa dirección.

---

## 3. Puntero a puntero

```c
int   x  = 42;
int  *p  = &x;
int **pp = &p;
```

```
pp → p → x → 42
```

Cada `*` es un paso, no un salto al final:

```c
*pp   // tipo: int* — valor: dirección de x (= p)
**pp  // tipo: int  — valor: 42
```

**Regla:** `int**` con un `*` aplicado → `int*`. Con dos `*` → `int`.

---

## 4. Pass-by-pointer para mutación

```c
void increment(int *p) {
    *p = *p + 1;
}

int main(void) {
    int x = 42;
    increment(&x);
    printf("%d\n", x);  // 43
}
```

```
main:        increment:
┌─────────┐  ┌──────────────┐
│ x = 42  │  │ p = &x       │  ← copia de la dirección, no del valor
└────↑────┘  └──────────────┘
     └─────────────*p
```

`p` es una copia — pero una copia de la dirección. `*p` sigue apuntando al `x` de `main`.

### Ejercicio: swap

```c
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main(void) {
    int a = 10, b = 20;
    swap(&a, &b);
    printf("%d %d\n", a, b);  // 20 10
}
```

---

## 5. Array Decay

En casi cualquier expresión, un array se convierte automáticamente en un puntero a su primer elemento.

```c
int arr[4] = {10, 20, 30, 40};
int *p = arr;           // equivalente a: int *p = &arr[0]
```

**No es pass-by-reference — es una conversión implícita de tipo.**

```c
sizeof(arr)  // 16 bytes — el array completo
sizeof(p)    //  8 bytes — solo el puntero
```

Si fuera pass-by-reference serían iguales.

### Consecuencia

```c
void print_len(int *arr) {
    printf("%zu\n", sizeof(arr));  // 8 — tamaño del puntero, SIEMPRE
}

int main(void) {
    int arr[4] = {10, 20, 30, 40};
    printf("%zu\n", sizeof(arr));  // 16 — correcto, antes del decay
    print_len(arr);                //  8 — ya decayó, perdiste la info
}
```

### Comparación con Go

| | C | Go |
|---|---|---|
| Array en expresión | Decae a puntero | Se copia completo (value type) |
| Slice/puntero | Manual con `&arr[0]` | Implícito en la struct del slice |
| Tamaño | Se pierde al pasar a función | `len()` siempre disponible |

El slice de Go es una struct con 3 campos: `{ ptr *T, len int, cap int }`. Diseñado exactamente para resolver el problema del decay.

---

## 6. Convención `(ptr, len)` en C

Como la función pierde el tamaño del array al recibirlo, la convención es pasarlo explícitamente.

```c
// ❌ Sin tamaño — no sabes cuántos elementos procesar
void imprimir(int *arr) { ... }

// ✅ Convención correcta
void imprimir(int *arr, size_t len) {
    for (size_t i = 0; i < len; i++) {
        printf("%d\n", arr[i]);
    }
}
```

### Por qué `size_t` y no `int`

- `size_t` es unsigned, garantizado de 64 bits en sistemas de 64 bits
- Usar `int` para tamaños genera comparaciones signed/unsigned — warning con `-Wall`
- Si retornas un índice `size_t` como `int`, castea explícitamente: `return (int)i;`

### Macro helper

```c
#define ARRAY_LEN(arr) (sizeof(arr) / sizeof((arr)[0]))

int arr[] = {10, 20, 30, 40, 50};
imprimir(arr, ARRAY_LEN(arr));  // correcto — arr aún no ha decaído
```

⚠️ `ARRAY_LEN` solo es correcto en el scope donde el array fue declarado. Dentro de una función que lo recibió como parámetro, ya decayó y el resultado es incorrecto.

---

## 7. Por qué un puntero mide 8 bytes en tu Mac

Un puntero guarda una dirección de memoria. En ARM64 (Apple Silicon) el espacio de direcciones es de 64 bits → cualquier dirección ocupa 64 bits = **8 bytes**.

| Arquitectura | Espacio de direcciones | Tamaño del puntero |
| ------------ | ---------------------- | ------------------ |
| 16 bits      | 2^16 = 65,536 bytes    | 2 bytes            |
| 32 bits      | 2^32 = 4 GB            | 4 bytes            |
| 64 bits      | 2^64 = 16 exabytes     | 8 bytes            |

```c
sizeof(int *)    // 8 — puntero a int
sizeof(char *)   // 8 — puntero a char
sizeof(void *)   // 8 — puntero a cualquier cosa
sizeof(double *) // 8 — puntero a double
```

El tipo al que apunta no importa — todos los punteros miden lo mismo.

---

## 8. Ejercicio final: búsqueda lineal

```c
int buscar(int *arr, size_t len, int objetivo) {
    for (size_t i = 0; i < len; i++) {
        if (objetivo == arr[i]) {
            return (int)i;  // cast explícito: size_t → int
        }
    }
    return -1;
}
```

**Complejidad:**
- Mejor caso: O(1) — objetivo en `arr[0]`
- Peor caso: O(n) — objetivo en `arr[n-1]` o no existe
- Promedio: O(n)

---

## Conceptos dominados al cerrar Clase 2

- [x] `&x` — obtener dirección
- [x] `int *p` — declarar puntero
- [x] `*p` — dereference
- [x] `int **pp` — puntero a puntero
- [x] Pass-by-pointer para mutación
- [x] Array decay vs pass-by-reference
- [x] Convención `(ptr, len)`
- [x] `size_t` vs `int` para índices
- [x] Tamaño de punteros en 64-bit

---

## Siguiente clase

**Clase 3 — Aritmética de Punteros**
- `p + 1`, `p++` y `p[i]` son la misma cosa
- Cómo el compilador escala por `sizeof(T)`
- Iteración sobre arrays con punteros
