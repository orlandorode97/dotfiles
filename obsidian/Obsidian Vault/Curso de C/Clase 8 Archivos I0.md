# Clase 8 — Archivos & I/O en C

## FILE * — qué es realmente
- NO es un file descriptor — es un puntero a struct
- Adentro vive: `int fd` + buffer userspace + flags (EOF, error) + posición
- El buffer es lo que diferencia FILE * de llamar `read()`/`write()` de POSIX directo
- `fd` es solo un `int` — índice en la tabla de archivos del kernel

## fopen / fclose
```c
FILE *f = fopen("archivo.bmp", "rb");  // "rb" = read binary
if (f == NULL) {
    perror("fopen");  // errno está seteado aquí
    return 1;
}
// ... usar f ...
fclose(f);  // obligatorio en TODOS los paths, incluyendo errores
```
**Modos comunes:** `"r"`, `"w"`, `"rb"`, `"wb"`, `"r+"`, `"a"`

## fread / fwrite — semántica exacta
```c
// Lee 1 elemento de sizeof(T) bytes
size_t n = fread(&mi_struct, sizeof(MiStruct), 1, f);

// Retorna cuántos ELEMENTOS leyó (no bytes)
// Si n != count → algo falló
if (n != 1) {
    if (feof(f))   { /* EOF prematuro   */ }
    if (ferror(f)) { perror("fread");    }
}
```
- `fread` NO setea errno de forma confiable — usar `feof()`/`ferror()`
- Nunca hardcodear tamaños — siempre `sizeof()`
- Nunca pasar `NULL` a fread — el check de fopen es obligatorio antes

## Pattern: leer header binario
```c
BMPFileHeader fh;
fread(&fh, sizeof(BMPFileHeader), 1, f);
// validar magic number ANTES de leer el siguiente header
if (fh.signature[0] != 'B' || fh.signature[1] != 'M') { ... }
```

## feof / ferror
- NO usar `feof()` como condición de loop — el flag se setea DESPUÉS del read fallido
- Usar DESPUÉS de que fread/fgets retorna un valor inesperado
- `ferror()` → error de I/O → aquí sí tiene sentido `perror()`

## Buffering
| Modo | Cuándo flushea | Quién |
|------|---------------|-------|
| UNBUFFERED | inmediato | stderr siempre |
| LINE BUFFERED | en `\n` o buffer lleno | stdout → terminal |
| FULLY BUFFERED | buffer lleno (~8KB) | stdout → archivo/pipe, archivos regulares |

- `stdout` cambia de line buffered a fully buffered cuando se redirige (`>`, `|`)
- `stderr` es siempre unbuffered → por eso los errores aparecen aunque stdout esté redirigido

## fflush
```c
fflush(f);   // fuerza flush del buffer al kernel
```
- Usar antes de operaciones que pueden crashear
- Usar si necesitas garantizar que el output llegó antes de continuar
- **Smell**: fflush dentro de un loop de escritura masiva → destruye performance

## Verificar layout de struct con BMP
```
file_size = pixel_offset + (width × height × bytes_per_pixel)
6,220,938 = 138 + (1920 × 1080 × 3)  ✓
```
- `header_size` del DIB header indica la versión: 40=V1, 108=V4, 124=V5
- Los primeros 40 bytes son comunes a todas las versiones → struct base funciona

## Errores a stderr, no stdout
```c
fprintf(stderr, "error: archivo inválido\n");  // ✓
printf("error: archivo inválido\n");           // ✗
```

## Format specifiers con tipos exactos
```c
uint32_t x;  printf("%u", x);   // ✓
int32_t  y;  printf("%d", y);   // ✓
uint16_t z;  printf("%u", z);   // ✓
// %d con uint → warning con -Wall → error con -Werror
```
```

---

## Prompt para la Clase 9
```
Actúa como un ingeniero de software senior enseñando C a alguien con 7 años 
de experiencia en Go.

El estudiante ya domina todo lo de clases anteriores más:
- FILE * como struct con buffer userspace + fd + flags
- fopen/fclose con manejo correcto de NULL y fclose en todos los paths
- fread/fwrite — semántica de retorno por elementos, no bytes
- feof/ferror — cuándo usarlos y cuándo no
- Buffering: unbuffered (stderr), line buffered (stdout→terminal), 
  fully buffered (stdout→archivo/pipe)
- fflush — cuándo es necesario y cuándo es un smell
- Leyó un header BMP binario real con __attribute__((packed)) y fread
- Validó magic numbers y detectó versiones de header con header_size

Clase 9 — Punteros avanzados:
- Punteros a funciones: sintaxis, typedef, casos de uso reales
- Callbacks: patrón qsort, implementar sort genérico propio
- void * — genericidad sin templates, casts seguros e inseguros
- Function pointers en structs — simulando vtables / polimorfismo manual

El estudiante aprende mejor cuando razona primero y compila después.
Abre con una pregunta que conecte con Go: en Go usas funciones como 
valores de primera clase (func como tipo, closures, interfaces). 
Pregúntale qué espera que sea un puntero a función en C y cómo cree 
que C logra polimorfismo sin interfaces ni generics.