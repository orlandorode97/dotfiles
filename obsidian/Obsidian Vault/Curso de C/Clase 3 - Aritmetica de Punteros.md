# Clase 3 — Aritmética de Punteros

## La regla fundamental

```c
(T*)p  +  n   ==   (byte*)p  +  (n × sizeof(T))
```

El compilador **escala automáticamente** por el tamaño del tipo. Siempre. Sin excepción.

```c
int nums[] = {10, 20, 30, 40, 50};
// Si &nums[0] == 0x1000 y sizeof(int) == 4:

nums + 0  →  0x1000   // nums[0]
nums + 1  →  0x1004   // nums[1]
nums + 2  →  0x1008   // nums[2]
nums + 3  →  0x100C   // nums[3]  ← no 0x1003
nums + 4  →  0x1010   // nums[4]
```

> [!warning] Error mental común `nums + 3` **no** suma 3 bytes. Suma `3 × sizeof(int)` = 12 bytes. El tipo del puntero determina el salto.

---

## `p[i]` y `*(p + i)` son la misma expresión

El estándar de C los define como **idénticos** — no es una optimización, es una identidad:

```c
nums[3]      ==   *(nums + 3)   // por definición del estándar
```

Prueba: como la suma es conmutativa, `*(a + i) == *(i + a)`, entonces:

```c
nums[3]  ==  3[nums]   // ✅ compila y funciona — nunca lo uses, pero entiende por qué
```

Con `-O0` el assembly de `nums[i]` y `*(nums + i)` es **idéntico** — el compilador procesa la misma expresión.

---

## Las tres formas de iterar un array

```c
int nums[] = {10, 20, 30, 40, 50};
size_t len  = sizeof(nums) / sizeof(nums[0]);

// ── Forma 1: índice entero ──────────────────────────────────────────
// Equivalente a: for i, v := range nums en Go
for (size_t i = 0; i < len; i++) {
    printf("%d\n", nums[i]);       // *(nums + i) internamente
}

// ── Forma 2: puntero que avanza ────────────────────────────────────
for (int *p = nums; p < nums + len; p++) {
    printf("%d\n", *p);
}

// ── Forma 3: sentinel hoisteado — idiomático en código serio ───────
int *end = nums + len;             // calculado una sola vez, explícito
for (int *p = nums; p < end; p++) {
    printf("%d\n", *p);
}
```

Las tres formas generan **assembly idéntico** con `-O2`. La elección es sobre claridad de intención, no performance.

---

## El sentinel `end` — por qué apunta más allá del array

```
0x1000  [ 10 ]  nums[0]
0x1004  [ 20 ]  nums[1]
0x1008  [ 30 ]  nums[2]
0x100C  [ 40 ]  nums[3]
0x1010  [ 50 ]  nums[4]  ← último elemento válido
0x1014  [    ]  ← end apunta aquí
```

El estándar de C **garantiza** que `arr + len` es una dirección válida para comparar. Desreferenciarlo es UB. Es el mismo contrato que Go usa internamente con sus slices.

---

## Loop-invariant code motion — cuándo el compilador puede y no puede hoistear

```c
// ✅ El compilador puede hoistear — nums y len son locales, no cambian
for (int *p = nums; p < nums + len; p++) { ... }
// Con -O2 se convierte en:
//   end = nums + len  ← una sola vez
//   while (p < end)

// ❌ El compilador NO puede hoistear — aliasing problem
for (int *p = arr; p < arr + *len_ptr; p++) {
    process(p);    // ¿modifica *len_ptr? el compilador no lo sabe
}
```

|Situación|¿Hoisteado automático?|
|---|---|
|`len` es variable local|✅ Siempre|
|`*len_ptr` depende de un puntero|❌ Posible aliasing|
|`global_len` variable global|❌ Una función interna podría modificarla|

> [!note] Por eso la Forma 3 es idiomática No dependes del análisis del compilador. La intención es explícita y siempre correcta.

---

## Iteración al revés — el UB que hay que evitar

### ❌ Versión con UB

```c
void print_reverse_WRONG(const int *arr, size_t len) {
    const int *end = arr + len - 1;
    for (const int *p = end; p >= arr; p--) {
        printf("%d\n", *p);     // última iteración: p-- → arr - 1 → UB
    }
}
```

Traza la última iteración:

```
p == arr  →  entra al loop, imprime arr[0]  ✅
p--       →  p = arr - 1                    ← UB: dirección inválida
p >= arr  →  comparación con puntero inválido ← UB
```

### ✅ Versión correcta — `--p` antes de desreferenciar

```c
void print_reverse(const int *arr, size_t len) {
    const int *end = arr + len;      // sentinel estándar — un más allá

    for (const int *p = end; p > arr; ) {
        --p;                         // retroceder PRIMERO
        printf("%d\n", *p);         // luego desreferenciar
    }
}
```

Traza:

```
p == arr + 1  →  entra, --p → arr  ✅ dirección válida, imprime arr[0]
p > arr       →  false → sale      ✅ p nunca llega a arr - 1
```

> [!important] Regla El estándar garantiza `arr + len` como dirección válida para aritmética. `arr - 1` **no tiene garantía**. Con iteración hacia atrás, el truco es `--p` antes de desreferenciar, nunca después.

---

## Retornar "no encontrado" — `NULL` como sentinel

```c
int *find(const int *arr, size_t len, int target) {
    const int *end = arr + len;
    for (const int *p = arr; p < end; p++) {
        if (*p == target) {
            return (int *)p;    // puntero al elemento dentro del array
        }
    }
    return NULL;                // "no existe"
}

// El caller DEBE verificar — siempre
int *result = find(nums, len, 30);
if (result == NULL) {
    printf("no encontrado\n");
} else {
    printf("encontrado: %d\n", *result);
}
```

---

## Comparación con Go

|Concepto|C|Go|
|---|---|---|
|Aritmética de punteros|Explícita — `p + n` escala por `sizeof(T)`|Oculta dentro del runtime de slices|
|`arr[i]`|Azúcar sintáctica de `*(arr + i)`|Bounds checking implícito en runtime|
|Iteración|Manual con punteros o índices|`for i, v := range slice`|
|"No encontrado"|`return NULL`|`return 0, false` — múltiples retornos|
|UB en bounds|Silencioso — corrupción de memoria|Panic en runtime|

> [!note] El precio de no tener runtime En Go `s[i]` tiene bounds checking. En C `arr[i]` es `*(arr + i)` — acceso directo a memoria, sin verificación. Más rápido, más peligroso. AddressSanitizer (`-fsanitize=address`) compensa esto en desarrollo.

---

## Macro útil

```c
#define ARRAY_LEN(arr) (sizeof(arr) / sizeof(arr[0]))

// Solo funciona con arrays declarados en scope — no con punteros recibidos como parámetro
int nums[] = {1, 2, 3, 4, 5};
size_t len = ARRAY_LEN(nums);   // ✅

void foo(int *arr) {
    size_t len = ARRAY_LEN(arr); // ❌ sizeof de puntero, no del array
}
```

---

## Ejercicio de la clase

```c
// Escribir usando solo aritmética de punteros — sin índices
void print_reverse(const int *arr, size_t len);

// Implementar búsqueda con retorno NULL
int *find(const int *arr, size_t len, int target);
```

---

## Checklist

- [x] `p + n` escala por `sizeof(T)` — nunca suma bytes crudos
- [x] `arr[i]` == `*(arr + i)` — identidad del estándar, assembly idéntico
- [x] `arr + len` es válido para comparar, nunca para desreferenciar
- [x] `arr - 1` es UB — la iteración inversa requiere `--p` antes de `*p`
- [x] `const int *` — aplicar siempre que no se modifica el contenido
- [x] `%zu` para `size_t` en `printf` — `%d` con cast es incorrecto
- [x] Hoistear el sentinel explícitamente cuando el compilador no puede analizarlo

---

## Links

- [[C - Clase 2 - Punteros]]
- [[C - Clase 4 - typedef y Punteros a Función]] _(próxima)_