ah
## Forward Declaration

Declarar un struct **sin definirlo**. Le dice al compilador: _"este tipo existe"_.

```c
struct Queue;  // tipo incompleto — sin campos, sin tamaño
```

Con esto el compilador puede:

- ✅ Compilar `struct Queue *q` — el puntero son 8 bytes, tamaño conocido
- ✅ Aceptar firmas de funciones que reciben o retornan `Queue *`
- ❌ Calcular `sizeof(Queue)` — tamaño desconocido
- ❌ Acceder a campos — `q->len` — no sabe que existen

> [!note] Tipo incompleto Un tipo declarado pero no definido se llama **tipo incompleto**. No puedes instanciarlo ni medir su tamaño, pero sí puedes tener punteros a él.

---

## Puntero Opaco

Un puntero a un tipo incompleto. El consumidor tiene el handle pero **nunca puede ver los campos**.

```c
// queue.h — lo que ve el consumidor
struct Queue;             // tipo incompleto
typedef struct Queue Queue;

Queue *queue_create(size_t capacity);  // retorna un handle
void   queue_destroy(Queue *q);
```

El consumidor puede hacer `Queue *q = queue_create(8)` pero no puede hacer `q->len` porque el compilador nunca vio la definición del struct.

---

## El Patrón Handle / API

Equivalente en C de la encapsulación orientada a objetos.

### Los tres archivos

```
queue.h   — interfaz pública (lo que ve el consumidor)
queue.c   — implementación (donde vive la definición real)
main.c    — consumidor (solo incluye el .h)
```

### `queue.h` — interfaz

```c
#ifndef QUEUE_H
#define QUEUE_H

#include <stddef.h>

struct Queue;
typedef struct Queue Queue;

Queue *queue_create(size_t capacity);
void   queue_destroy(Queue *q);
int    queue_push(Queue *q, int value);   // 0 ok, -1 full
int    queue_pop(Queue *q, int *out);     // 0 ok, -1 vacío
size_t queue_len(const Queue *q);

#endif
```

### `queue.c` — implementación

```c
#include "queue.h"
#include <stdlib.h>

// Definición completa — solo visible en este archivo
struct Queue {
    int    *items;
    size_t  len;
    size_t  capacity;
};

Queue *queue_create(size_t capacity) {
    Queue *q = malloc(sizeof(Queue));  // sizeof OK — estamos en el .c
    if (!q) return NULL;

    q->items = malloc(sizeof(int) * capacity);
    if (!q->items) {
        free(q);
        return NULL;
    }

    q->len      = 0;
    q->capacity = capacity;
    return q;
}

void queue_destroy(Queue *q) {
    if (!q) return;
    free(q->items);
    free(q);
}

int queue_push(Queue *q, int value) {
    if (q->len == q->capacity) return -1;
    q->items[q->len++] = value;
    return 0;
}

int queue_pop(Queue *q, int *out) {
    if (q->len == 0) return -1;
    *out = q->items[0];
    for (size_t i = 1; i < q->len; i++) {
	     q->items[i - 1] = q->items[i];
	}
	q->len--;
    return 0;
}

size_t queue_len(const Queue *q) {
    return q->len;
}
```

### `main.c` — consumidor

```c
#include "queue.h"
#include <stdio.h>

int main(void) {
    Queue *q = queue_create(8);
    if (!q) {
        fprintf(stderr, "error: queue_create failed\n");
        return 1;
    }

    queue_push(q, 10);
    queue_push(q, 20);

    int val;
    while (queue_pop(q, &val) == 0) {
        printf("pop: %d\n", val);
    }

    queue_destroy(q);
    return 0;
}

// Esto NO compila:
// q->len = 999;
// error: incomplete type 'Queue'
```

---

## Include Guards

Protección contra inclusión múltiple. El preprocesador hace copy-paste literal de los `.h` — sin guards, un tipo puede quedar definido dos veces en la misma unidad de compilación.

```c
// a.h incluye queue.h
// b.h incluye queue.h
// main.c incluye a.h y b.h
// → queue.h se expande DOS veces → redefinition error
```

### La solución

```c
#ifndef QUEUE_H   // ¿existe esta macro? no → entra
#define QUEUE_H   // la define

// contenido del header

#endif            // fin del bloque protegido
```

Segunda inclusión: `#ifndef` ve que `QUEUE_H` ya existe → salta todo el bloque. El compilador nunca ve el duplicado.

> [!warning] El nombre es solo una llave `QUEUE_H` no es especial. Podría ser cualquier cosa. Lo importante es que sea **único por archivo** — convención: `NOMBRE_ARCHIVO_H` en mayúsculas.

---

## Out-Parameters — El `(ok, value)` de C

Go tiene múltiples valores de retorno. C no. El out-parameter es el equivalente.

```go
// Go
val, ok := q.Pop()
```

```c
// C
int val;
int ok = queue_pop(q, &val);  // ok → ¿funcionó? val → el dato
```

**Por qué no simplemente retornar el valor:**

```c
// ❌ ambiguo
int queue_pop(Queue *q) {
    if (q->len == 0) return -1;   // error
    return q->items[--q->len];    // ¿y si el valor es -1?
}
```

Si el valor legítimo es `-1`, es imposible distinguirlo del error. El out-parameter separa los dos canales de información.

---

## `static` — Funciones Privadas

`static` a nivel de archivo restringe la visibilidad a esa unidad de compilación. Nadie fuera del `.c` puede llamarla. Equivalente a un método privado.

```c
// solo visible dentro de stack.c
static int stack_top(const Stack *s, int *out) {
    if (s->len == 0) return -1;
    *out = s->items[s->len - 1];
    return 0;
}

// pop y peek reutilizan stack_top — sin duplicar lógica
int stack_pop(Stack *s, int *out) {
    int rc = stack_top(s, out);
    if (rc == 0) s->len--;
    return rc;
}

int stack_peek(Stack *s, int *out) {
    return stack_top(s, out);
}
```

---

## Compilar con múltiples archivos

```bash
# Compilar cada unidad por separado
clang -Wall -Wextra -Werror -g -fsanitize=address,undefined -c queue.c -o queue.o
clang -Wall -Wextra -Werror -g -fsanitize=address,undefined -c main.c  -o main.o

# Linkear
clang -fsanitize=address,undefined queue.o main.o -o programa

# O en un paso (útil mientras se desarrolla)
clang -Wall -Wextra -Werror -g -fsanitize=address,undefined queue.c main.c -o programa
```

|Fase|Qué necesita|Qué hace|
|---|---|---|
|**compile time**|Solo el `.h`|Verifica tipos, firmas, tamaños|
|**link time**|El `.o` / `.a`|Conecta llamadas con implementación|

---

## Analogía con Go

|Go|C|
|---|---|
|`package queue`|`queue.c` + `queue.h`|
|campo unexported|campo definido solo en el `.c`|
|`type Queue struct`|`struct Queue` en el `.c`|
|`func NewQueue() *Queue`|`queue_create()`|
|`*Queue` como handle|`Queue *` como handle|
|el compilador **prohíbe** el acceso|el compilador **no conoce** los campos|

> [!tip] Diferencia filosófica
> 
> - Go dice **"no puedes"**
> - C dice **"no sabes que existe"**
> 
> El resultado práctico es el mismo. El mecanismo es distinto.

---

## Errores Comunes

> [!danger] No detener el flujo después de un error

```c
// ❌ out queda sin inicializar si peek falla
int out;
if (stack_peek(s, &out) == -1) {
    fprintf(stderr, "error\n");
    // falta return — cae al printf con out basura
}
printf("%d\n", out);  // UB

// ✅
if (stack_peek(s, &out) == -1) {
    fprintf(stderr, "error\n");
    stack_destroy(s);
    return 1;
}
printf("%d\n", out);
```

> [!danger] No chequear NULL después de malloc

```c
// ❌
Stack *s = stack_create(8);
stack_push(s, 1);  // si malloc falló, s es NULL → crash

// ✅
Stack *s = stack_create(8);
if (!s) {
    fprintf(stderr, "error: stack_create failed\n");
    return 1;
}
```

---

## Patrones idiomáticos vistos

```c
// Post-incremento en asignación
s->items[s->len++] = value;   // escribe en len, luego incrementa

// Pre-decremento en lectura
*out = s->items[--s->len];    // decrementa primero, luego lee

// Guard de NULL en destroy
void stack_destroy(Stack *s) {
    if (!s) return;   // free(NULL) es UB en algunos contextos — mejor guardarlo
    free(s->items);
    free(s);
}
```

---

## Mapa mental

```
queue.h ──────────────────────────────────────────────
  struct Queue;          ← tipo incompleto
  Queue *queue_create()  ← firma pública
         │                        │
         ↓ incluye                ↓ incluye
    queue.c                    main.c
    struct Queue {             Queue *q = queue_create();
        int *items;            queue_push(q, 10);
        size_t len;            // q->len = 99 → NO COMPILA
        size_t capacity;
    };
```