# Clase 9 — Punteros Avanzados

Tags: #c #pointers #callbacks #generics #vtable

---

## Mapa de la clase

```
puntero a función → callback → void * genérico → vtable manual
```

Cada pieza es bloque del siguiente.

---

## 1. Punteros a Función

### Modelo mental

Una función en C es código máquina en una dirección fija de memoria. Un puntero a función es literalmente esa dirección.

```
0x4006a0:  push rbp   ← aquí empieza int add(int a, int b)
0x4006a1:  mov rbp, rsp
...
int (*fp)(int, int) = add;
// fp == 0x4006a0
// fp(1, 2) == saltar a 0x4006a0 con esos argumentos
```

> ⚠️ No hay objeto. No hay closure. No hay tipo en runtime. Solo una dirección.

### Sintaxis — leer de adentro hacia afuera

```c
int (*fp)(int, int);
// fp        → variable llamada fp
// (*fp)     → que es un puntero
// (*fp)(int,int) → a algo que recibe dos int
// int (...)  → y retorna int
```

El paréntesis alrededor de `*fp` es **obligatorio**:

```c
int *fp(int, int);   // ❌ función que retorna int*
int (*fp)(int, int); // ✅ puntero a función que retorna int
```

### typedef — forma limpia

```c
typedef int (*BinaryOp)(int, int);

BinaryOp fp  = add;    // limpio
BinaryOp ops[10];      // array de punteros a función — válido
```

### Llamada — dos formas equivalentes

```c
int r1 = fp(3, 4);     // forma moderna — preferida
int r2 = (*fp)(3, 4);  // forma explícita — también válida
```

### Decay automático

El nombre de una función **decae automáticamente** a puntero a esa función, igual que un array decae a puntero al primer elemento.

```c
BinaryOp ops[2] = { add, mul };  // sin cast — el compilador verifica la firma
```

---

## 2. Callbacks — patrón qsort

### Firma de qsort

```c
void qsort(
    void   *base,    // puntero al primer elemento
    size_t  nmemb,   // cantidad de elementos
    size_t  size,    // tamaño de cada elemento en bytes
    int   (*compar)(const void *, const void *)
);
```

### Comparador correcto

```c
int cmp_int(const void *a, const void *b) {
    int ia = *(const int *)a;
    int ib = *(const int *)b;
    return (ia > ib) - (ia < ib);  // ✅ sin overflow
    // return ia - ib;              // ❌ overflow con INT_MIN
}
```

### Comparador de structs

```c
typedef struct {
    char name[32];
    int  age;
} Person;

int cmp_age(const void *a, const void *b) {
    const Person *p1 = (const Person *)a;  // cast 1
    const Person *p2 = (const Person *)b;  // cast 2 — son independientes
    return (p1->age > p2->age) - (p1->age < p2->age);
}

int cmp_name(const void *a, const void *b) {
    const Person *p1 = (const Person *)a;
    const Person *p2 = (const Person *)b;
    return strcmp(p1->name, p2->name);
}
```

---

## 3. void * — genericidad sin templates

### Diferencia clave con Go

```
interface{} en Go (2 palabras):
┌─────────────────┬─────────────────┐
│  *tipo (itab)   │  *dato          │
│  sabe QUÉ ES    │  sabe DÓNDE     │
└─────────────────┴─────────────────┘

void * en C (1 palabra):
┌─────────────────┐
│  dirección      │
│  no sabe nada   │
└─────────────────┘
```

> `void *` no sabe si apunta a un `int`, un `struct`, o basura. **Vos sos el compilador.**

### Reglas

```c
void *p;

int x = 42;
p = &x;           // ✅ cualquier puntero → void* sin cast (C, no C++)
int *ip = p;      // ✅ void* → tipo concreto sin cast (C, no C++)

*p = 10;          // ❌ no se puede desreferenciar void*
p++;              // ❌ aritmética inválida — tamaño desconocido
```

### Por qué char * para aritmética genérica

```c
// ❌ no compila — void* no tiene tamaño para avanzar
void *elem_i = base + i * size;

// ✅ char tiene sizeof == 1, siempre, por estándar
char *elem_i = (char *)base + i * size;
```

`char *` es el único tipo que garantiza aritmética byte a byte sin UB. Por eso `memcpy`, `memmove` y todo código genérico de bajo nivel lo usan.

---

## 4. Sort genérico propio

```c
void my_sort(void *base, size_t num, size_t size,
             int (*cmp)(const void *, const void *)) {

    if (num < 2) return;         // ✅ guarda para size_t underflow

    void *temp = malloc(size);   // ✅ fuera del loop — 1 alloc total
    if (!temp) return;

    for (size_t i = 0; i < num - 1; i++) {
        for (size_t j = 0; j < num - i - 1; j++) {
            void *a = (char *)base + j * size;
            void *b = (char *)base + (j + 1) * size;
            if (cmp(a, b) > 0) {
                memcpy(temp, a, size);
                memcpy(a, b, size);
                memcpy(b, temp, size);
            }
        }
    }
    free(temp);
}
```

### Bugs clásicos a evitar

|Bug|Consecuencia|
|---|---|
|`malloc` dentro del loop|Miles de allocs innecesarios|
|`if (!temp) continue`|Array parcialmente ordenado, caller no lo sabe|
|`num - 1` sin guardar `num < 2`|`size_t` underflow → loop infinito|
|`return ia - ib` en comparador|Integer overflow silencioso con valores extremos|

---

## 5. Vtables manuales — polimorfismo sin interfaces

### La "interface" en C es un struct de punteros a funciones

```c
typedef struct {
    const char *(*sound)(void *self);
    void        (*move) (void *self);
} AnimalVTable;

typedef struct {
    void         *data;
    AnimalVTable *vtable;
} Animal;
```

### Implementación concreta

```c
typedef struct { char name[32]; } Dog;

const char *dog_sound(void *self) { (void)self; return "woof"; }
void        dog_move (void *self) {
    printf("%s runs\n", ((Dog *)self)->name);
}

AnimalVTable dog_vtable = { dog_sound, dog_move };

Animal make_dog(Dog *d) {
    return (Animal){ .data = d, .vtable = &dog_vtable };
}
```

### Dispatch dinámico

```c
void make_noise(Animal a) {
    printf("%s\n", a.vtable->sound(a.data));
}

// uso:
Animal animals[] = { make_dog(&d), make_cat(&c) };
for (int i = 0; i < 2; i++)
    make_noise(animals[i]);
```

> Esto es lo que C++ genera automáticamente con `virtual`. En C, **vos sos el compilador**.

---

## Mapa Go → C

|Go|C|
|---|---|
|`func(int,int) bool` como tipo|`typedef int (*Pred)(int,int)`|
|pasar función como argumento|pasar `fp` del tipo correcto|
|`interface{}` / `any`|`void *` — pero **sin** info de tipo|
|interface con métodos|struct con punteros a funciones (vtable)|
|dispatch dinámico automático|`obj.vtable->method(obj.data)` manual|
|type switch seguro|cast + convención tuya, sin safety net|
|generics con type safety|`void *` — el compilador no te ayuda|

---

## Patrones para llevar

```c
// 1. typedef siempre para function pointers
typedef int (*Comparator)(const void *, const void *);

// 2. cast en dos pasos — primero el tipo, luego desreferenciar
int val = *(const int *)ptr;         // ✅
int val = *(int *)(const void *)ptr; // ❌ innecesariamente complejo

// 3. comparador sin overflow
return (a > b) - (a < b);   // retorna -1, 0, 1

// 4. aritmética genérica siempre con char *
(char *)base + i * size

// 5. malloc fuera del loop, free al final
void *tmp = malloc(size);
if (!tmp) return;
// ... loop ...
free(tmp);
```