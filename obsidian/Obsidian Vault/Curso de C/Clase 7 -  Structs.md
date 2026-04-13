# Clase 7 — Structs: Alignment, Padding y Memory Layout

**Tags:** #c #structs #memory #alignment #padding #systems

---

## La regla fundamental

> Cada campo debe comenzar en una dirección múltiplo de su propio tamaño.

|Tipo|Tamaño|Alignment (debe estar en offset múltiplo de...)|
|---|---|---|
|`char` / `uint8_t`|1 byte|1 → cualquier offset|
|`short` / `uint16_t`|2 bytes|2 → 0, 2, 4, 6...|
|`int` / `uint32_t`|4 bytes|4 → 0, 4, 8, 12...|
|`double` / `uint64_t`|8 bytes|8 → 0, 8, 16, 24...|

---

## Por qué existe el padding

La CPU lee memoria en bloques llamados **words** (8 bytes en ARM64/x86-64). Si un `int` está partido entre dos words, el procesador necesita dos accesos en lugar de uno. En ARM64 (Apple Silicon), accesos desalineados en ciertos contextos pueden generar un **bus error**.

El compilador inserta bytes de relleno (padding) para que cada campo caiga en su offset natural — no por desperdicio, sino para garantizar accesos de un solo ciclo.

---

## Dos tipos de padding

### 1. Padding interno (entre campos)

Se inserta antes de un campo cuyo offset natural no coincide con la posición actual.

```c
struct Foo {
    char  a;   // offset 0  — 1 byte
    // padding: bytes 1, 2, 3  ← int necesita múltiplo de 4
    int   b;   // offset 4  — 4 bytes
    char  c;   // offset 8  — 1 byte
};
// sizeof: 12
```

### 2. Trailing padding (al final del struct)

El tamaño total del struct debe ser múltiplo del alignment de su campo más grande. Necesario para que los arrays funcionen correctamente.

```c
struct FooPacked {
    int   b;   // offset 0  — 4 bytes
    char  a;   // offset 4  — 1 byte
    char  c;   // offset 5  — 1 byte
    // trailing padding: bytes 6, 7  ← size debe ser múltiplo de 4
};
// sizeof: 8
```

> **Por qué existe el trailing padding:** Si haces `struct Foo arr[2]`, el segundo elemento necesita que sus campos también estén alineados. Sin trailing padding, `arr[1]` empezaría en offset 6 y rompería el alignment de `int b`.

---

## `sizeof(struct)` ≠ suma de sus campos

```c
// suma de campos: 1 + 4 + 1 = 6 bytes
// sizeof real:                12 bytes
struct Foo { char a; int b; char c; };
```

Siempre verificar con `sizeof` y `offsetof`.

---

## Cómo visualizar el layout

```c
#include <stddef.h>  // offsetof

printf("sizeof : %zu\n", sizeof(struct Foo));
printf("offsetof a: %zu\n", offsetof(struct Foo, a));
printf("offsetof b: %zu\n", offsetof(struct Foo, b));
printf("offsetof c: %zu\n", offsetof(struct Foo, c));
```

---

## Optimizar reordenando campos

Regla: **ordenar de mayor a menor alignment** elimina el padding interno.

```c
// ❌ Subóptimo — 24 bytes
struct Bar {
    double  x;   // offset 0
    char    y;   // offset 8
    int     z;   // offset 12  (padding: bytes 9,10,11)
    char    w;   // offset 16
    // trailing padding: bytes 17-23
};

// ✓ Óptimo — 16 bytes
struct BarOpt {
    double  x;   // offset 0
    int     z;   // offset 8
    char    y;   // offset 12
    char    w;   // offset 13
    // trailing padding: bytes 14, 15
};
```

**33% menos memoria** solo cambiando el orden de declaración.

---

## `__attribute__((packed))`

Elimina **todo** el padding — el compilador ya no garantiza alignment.

```c
struct __attribute__((packed)) FooForce {
    char a;   // offset 0
    int  b;   // offset 1  ← desalineado, sin padding
    char c;   // offset 5
};
// sizeof: 6 (la suma exacta)
```

### Cuándo usarlo

Solo cuando mapeas bytes crudos de una fuente externa que define el layout:

|Caso|Ejemplo|
|---|---|
|Protocolos de red|TCP, UDP, DNS, ICMP headers|
|Formatos de archivo binario|BMP, PNG, ELF, ZIP|
|Comunicación con hardware|Registros de dispositivos, USB HID|
|Serialización binaria|Mensajes entre servicios sin Protobuf|

### La regla de oro con `packed`

```c
// ✓ OK — leer el campo directamente
uint16_t port = header->src_port;

// ❌ Nunca — tomar dirección de campo desalineado → UB / bus error en ARM64
procesar(&header->src_port);
```

### Por qué los protocolos ya no necesitan `packed`

Los diseñadores de TCP (1981), DNS (1983) y otros protocolos ordenaron sus campos para que **ya estuvieran naturalmente alineados**. `packed` es solo la garantía explícita de que el compilador no agregue padding adicional — no cambia el sizeof.

```c
// DNS Header — con o sin packed: 12 bytes (idéntico)
struct DNSHeader {
    uint16_t id;       // offset 0
    uint8_t  flags_hi; // offset 2
    uint8_t  flags_lo; // offset 3
    uint16_t qdcount;  // offset 4
    uint16_t ancount;  // offset 6
    uint16_t nscount;  // offset 8
    uint16_t arcount;  // offset 10
};
```

> Los diseñadores de protocolos no usaron `packed` — **diseñaron el layout para que no lo necesitara**. `packed` es el parche cuando no controlas el diseño.

---

## La distinción clave

|Objetivo|Quién controla el layout|Herramienta|
|---|---|---|
|Minimizar memoria en tu proceso|Tú|Reordenar campos|
|Cumplir un layout externo exacto|El estándar / protocolo|`packed`|

Son problemas ortogonales.

---

## Resumen de reglas

1. Cada campo → offset múltiplo de su tamaño
2. Tamaño total → múltiplo del alignment del campo más grande
3. Para optimizar → ordenar de mayor a menor alignment
4. `packed` → solo para protocolos/formatos externos, nunca tomar dirección de sus campos
5. Siempre verificar con `sizeof` y `offsetof`, nunca confiar en cálculo mental