# Clase 1 — Fundamentos y Modelo de Memoria

> **Curso**: Go → C  
> **Semana**: 1 de 8  
> **Tiempo**: ~1 hora  
> **Estado**: ✅ Completada

---

## Conceptos cubiertos

### 1. Cada variable es una dirección

Toda variable vive en una dirección de memoria. `&x` te da esa dirección.

```c
int x = 42;
printf("%p\n", (void*)&x); // dirección donde vive x
```

---

### 2. Layout de memoria de un proceso

```
Dirección alta
┌─────────────────┐
│     STACK       │ ← variables locales, args de funciones
│  crece ↓        │
├─────────────────┤
│      ...        │
│  crece ↑        │
│     HEAP        │ ← malloc (semana 3)
├─────────────────┤
│  Globals/Static │ ← variables globales
├─────────────────┤
│  Text (código)  │ ← funciones, instrucciones
└─────────────────┘
Dirección baja
```

**Reglas clave:**
- El stack crece hacia **direcciones bajas**
- La primera variable declarada tiene la dirección **más alta**
- Cuando una función termina, su frame **desaparece** del stack
- Las funciones viven en el segmento de texto, separado del stack

---

### 3. Alineación y Padding

La CPU lee memoria en chunks de su tamaño natural (**word size**):

| Arquitectura | Word size |
|---|---|
| 8-bit (Arduino) | 1 byte |
| 32-bit (ESP32, Cortex-M) | 4 bytes |
| 64-bit (Apple Silicon, x86-64) | 8 bytes |

**Cada tipo debe estar en una dirección divisible por su tamaño:**

| Tipo | Tamaño | Alineación | Padding máximo |
|---|---|---|---|
| char | 1 byte | 1 | 0 |
| short | 2 bytes | 2 | 1 |
| int | 4 bytes | 4 | 3 |
| double | 8 bytes | 8 | 7 |

Cuando el compilador no puede cumplir la alineación, inserta **padding** (bytes vacíos de relleno).

```c
char   x;   // 1 byte  → offset 0
// 🚫 3 bytes de padding
int    y;   // 4 bytes → offset 4 (divisible entre 4 ✅)
char   z;   // 1 byte  → offset 8
```

**Fórmula:**
```
padding real = diferencia_de_direcciones - sizeof(tipo)
```

**Cache lines**: en la práctica, la CPU trae **64 bytes** a la vez a la caché, no solo el word. Por eso el acceso secuencial a memoria es mucho más rápido que el acceso aleatorio.

---

### 4. Undefined Behavior (UB)

> El concepto más importante de C.

Cuando rompes una regla del estándar, el compilador no está obligado a hacer nada predecible. Puede crashear, dar resultados incorrectos, o funcionar "bien" hasta que cambias el nivel de optimización.

**Ejemplos comunes:**
```c
int x;           // ❌ variable no inicializada
arr[10];         // ❌ fuera de bounds (sin panic como Go)
int max = INT_MAX;
max + 1;         // ❌ overflow de entero con signo
free(ptr);
*ptr = 5;        // ❌ use-after-free (semana 3)
```

**Por qué es peor que un crash:**
- Funciona en desarrollo, explota en producción
- `-O0` y `-O2` pueden dar resultados completamente distintos
- El compilador puede eliminar código silenciosamente
- Puede crear vulnerabilidades de seguridad invisibles

---

## Flags de compilación — usar siempre

```bash
clang -Wall -Wextra -Werror -g -fsanitize=address,undefined archivo.c -o output
```

| Flag | Propósito |
|---|---|
| `-Wall -Wextra` | Activa todos los warnings importantes |
| `-Werror` | Convierte warnings en errores de compilación |
| `-g` | Incluye info de debug para lldb |
| `-fsanitize=address,undefined` | Detecta UB y errores de memoria en runtime |

> Regla: **todo warning es un UB potencial. Trátalo como error.**

---

## Mini proyecto completado

**`memory_map.c`** — programa que imprime el layout real de memoria del proceso: variables del stack en distintos frames, variable global, y direcciones de funciones.

---

## Conexión con Go

| Go                         | C                                      |
| -------------------------- | -------------------------------------- |
| Zero values automáticos    | Sin inicialización → basura (UB)       |
| Runtime verifica bounds    | Sin verificación → UB silencioso       |
| GC previene use-after-free | Tú eres el GC                          |
| `&x` existe igual          | `&x` existe igual, pero sin protección |

---

## Checkpoint ✅

- [x] El stack crece hacia direcciones bajas
- [x] Cada función tiene su propio frame que desaparece al terminar
- [x] La CPU requiere alineación → el compilador inserta padding
- [x] UB no es un crash predecible, es un contrato roto
- [x] Compilar siempre con `-Wall -Wextra -Werror -fsanitize=address,undefined`

---

## Siguiente clase

**Clase 2 — Punteros**

> Pregunta para abrir: si `&x` te da la dirección de `x`, ¿qué tipo usas para *guardar* esa dirección en una variable?
****