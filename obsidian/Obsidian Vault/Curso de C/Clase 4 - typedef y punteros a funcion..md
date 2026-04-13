# Clase 4 — `typedef` y Punteros a Función

#c #systems #backend #pointers #typedef

---

## Contexto

> En Go `HandlerFunc` es un tipo con nombre, identidad y validación del compilador. En C `void (*handler)(int, const char *)` colapsa el tipo y la variable en una sola expresión — el compilador no tiene vocabulario para hablar de algo que no tiene nombre.

**Problema central:** sin un nombre de tipo, no puedes:

- Reusar el contrato en múltiples lugares de forma segura
- Obtener errores semánticos útiles del compilador
- Actualizar la firma desde un único punto

---

## `typedef` — alias de tipo

`typedef` no crea un tipo nuevo. Crea un **alias** — un nombre para una construcción de tipo existente.

### Regla de sintaxis

La sintaxis sigue la misma lógica que una declaración normal — antepones `typedef` y el último identificador se convierte en el nombre del alias, no en el nombre de la variable.

```c
// Declaración normal → typedef
int x;                          // variable x de tipo int
typedef int Meters;             // Meters es el alias

void (*fn)(int);                // variable fn, puntero a función
typedef void (*Handler)(int);   // Handler es el alias
```

### Sin vs con `typedef`

```c
// Sin typedef — tipo anónimo, entrelazado con el nombre de variable
void (*on_connect)(int, const char *);
void (*on_disconnect)(int, const char *);
void (*on_error)(int, const char *);   // firma incorrecta → nadie lo sabe

// Con typedef — contrato central, el compilador valida
typedef void (*Handler)(int, const char *);

Handler on_connect;
Handler on_disconnect;
Handler on_error;   // firma incorrecta → error inmediato
```

---

## Dispatch Table

Array homogéneo de punteros a función — polimorfismo sin vtable.

```c
#include <stdio.h>

typedef void (*Handler)(int, const char *);

void on_connect(int fd, const char *addr)    { printf("connect  fd=%d\n", fd); }
void on_disconnect(int fd, const char *addr) { printf("disconnect fd=%d\n", fd); }
void on_error(int fd, const char *addr)      { printf("error    fd=%d\n", fd); }

int main(void) {
    Handler table[] = { on_connect, on_disconnect, on_error };
    size_t  len     = sizeof(table) / sizeof(table[0]);

    for (size_t i = 0; i < len; i++) {
        table[i](i, "127.0.0.1");
    }

    return 0;
}
```

**Limitación:** todos los handlers deben tener la misma firma — incluyendo el mismo tipo de datos que reciben.

---

## El patrón `void *ctx` — closures en C

### El problema

Si cada handler necesita datos distintos, modificar la firma para incluir todos los tipos posibles **acopla** implementaciones que no tienen nada que ver:

```c
// ❌ Acoplamiento innecesario
typedef void (*Handler)(int, struct Connection *, config_t *);

void on_connect(int fd, struct Connection *conn, config_t *cfg) {
    (void)cfg;   // on_connect no necesita cfg — ruido
}
```

Además: si aparece un nuevo tipo de dato, modificas la firma de **todos**.

### La solución — `void *`

`void *` transporta una dirección sin comprometerse con el tipo. El compilador no sabe qué hay ahí — tú sí, y haces el cast cuando lo necesitas.

Todos los punteros miden lo mismo (8 bytes en 64-bit) → el tipo al que apuntan es información que puedes diferir.

```c
typedef void (*Handler)(int fd, void *ctx);
```

Firma **estable para siempre**, sin importar qué datos necesite cada handler.

### Implementación completa

```c
#include <stdio.h>

typedef void (*Handler)(int fd, void *ctx);

typedef struct {
    const char *addr;
    int         port;
} ConnectCtx;

typedef struct {
    int         code;
    const char *message;
} ErrorCtx;

void on_connect(int fd, void *ctx) {
    ConnectCtx *c = (ConnectCtx *)ctx;   // yo sé qué hay aquí
    printf("connect  fd=%d addr=%s:%d\n", fd, c->addr, c->port);
}

void on_error(int fd, void *ctx) {
    ErrorCtx *e = (ErrorCtx *)ctx;       // yo sé qué hay aquí
    printf("error    fd=%d code=%d msg=%s\n", fd, e->code, e->message);
}
```

---

## Arrays paralelos — el anti-patrón

```c
// ❌ Contrato implícito — el compilador no puede verificarlo
Handler table[] = { on_connect, on_error };
void   *ctxs[]  = { &conn_ctx,  &err_ctx  };

// Si table[3] existe y ctxs tiene tamaño 2 → UB en runtime
// El sanitizer lo cobra, el compilador no lo previene
```

**Riesgo:** índices desincronizados → acceso a dirección vacía → Undefined Behavior.

---

## Struct `EventEntry` — la solución correcta

Handler y ctx viajan **juntos**. El compilador hace imposible desincronizarlos.

```c
typedef struct {
    Handler  fn;    // ← no llamar igual que el tipo (colisión de nombres)
    void    *ctx;
} EventEntry;
```

### Implementación final

```c
#include <stdio.h>

typedef void (*Handler)(int, void *);

typedef struct {
    Handler  fn;
    void    *ctx;
} EventEntry;

typedef struct {
    const char *addr;
    int         port;
} ConnectCtx;

typedef struct {
    int         code;
    const char *message;
} ErrorCtx;

void on_connect(int fd, void *ctx) {
    ConnectCtx *c = (ConnectCtx *)ctx;
    printf("connect  fd=%d addr=%s:%d\n", fd, c->addr, c->port);
}

void on_error(int fd, void *ctx) {
    ErrorCtx *e = (ErrorCtx *)ctx;
    printf("error    fd=%d code=%d msg=%s\n", fd, e->code, e->message);
}

int main(void) {
    ConnectCtx connect_ctx = { .addr = "127.0.0.1", .port = 8080 };
    ErrorCtx   error_ctx   = { .code = 500, .message = "internal error" };

    EventEntry table[] = {
        { .fn = on_connect, .ctx = &connect_ctx },
        { .fn = on_error,   .ctx = &error_ctx   },
    };

    size_t len = sizeof(table) / sizeof(table[0]);

    for (size_t i = 0; i < len; i++) {
        table[i].fn(i, table[i].ctx);
    }

    return 0;
}
```

```bash
clang -Wall -Wextra -Werror -g -fsanitize=address,undefined -o events events.c
./events
```

---

## Reglas de estilo

|❌ Evitar|✅ Preferir|Razón|
|---|---|---|
|Campo con el mismo nombre que su tipo (`Handler Handler`)|`.fn`, `.handler`, `.cb`|Colisión de nombres — compila pero confunde|
|Variables intermedias antes de inicializar el array|Inicialización inline en el array|El array es la fuente de verdad, no una copia|
|Arrays paralelos sincronizados por índice|Un array de structs|El compilador refuerza la cohesión|

---

## Resumen de patrones

|Patrón|En una línea|
|---|---|
|`typedef`|Dale nombre a un tipo para que el compilador hable tu vocabulario|
|`void *ctx`|Transporta estado arbitrario sin romper la firma|
|Dispatch table|Array de punteros a función — polimorfismo sin vtable|
|`(fn, ctx)` en struct|El closure de C — explícito, sin magia|

---

## Conexión con Go

El patrón `(fn, ctx)` **es** la implementación interna de interfaces en Go:

```c
// Lo que hay detrás de una interface{} en Go
typedef struct {
    void *type_info;  // itab — equivalente a .fn
    void *data;       // equivalente a .ctx
} GoInterface;
```

No es metáfora — es la implementación real del runtime de Go.

Cuando en Go un closure captura variables, el runtime empaqueta el estado capturado y lo pasa implícitamente. En C lo haces explícito con `void *ctx`.

---
# Ejercicio Clase 4 — CLI Command Dispatcher


---

## Objetivo

Construir el núcleo de despacho de un CLI tool con subcomandos, aplicando `typedef`, `void *ctx`, y dispatch tables.

```bash
./app serve   --port 8080 --workers 4
./app migrate --dsn "postgres://..." --dry-run 1
./app ping    --host "localhost" --timeout 30
```

---

## Arquitectura final

```
argv[1]  →  loop  →  parse(ctx, argc, argv)  →  fn(ctx)
```

Cada entrada de la tabla lleva **tres responsabilidades juntas**:

- `name` — identificador del subcomando
- `parse` — construye el ctx desde argv (on-demand)
- `fn` — ejecuta el comando con el ctx ya poblado
- `ctx` — destino del parseo, con valores por defecto

---

## Typedefs

```c
typedef void (*CommandFn)(void *ctx);
typedef void (*ParseFn)(void *ctx, int argc, char *argv[]);

typedef struct {
    CommandFn   fn;
    ParseFn     parse;
    void       *ctx;
    const char *name;
} Command;
```

---

## Structs de configuración

```c
typedef struct {
    int port;
    int workers;
} Serve;

typedef struct {
    char *dsn;
    int   dry_run;   // flag booleano — no char *
} Migrate;

typedef struct {
    char *host;
    int   timeout_s;
} Ping;
```

---

## Funciones de parseo

Cada parser valida `argc` **antes** de acceder a `argv`. Fallo ruidoso — errores van a `stderr`, no a `stdout`.

```c
void parse_serve(void *ctx, int argc, char *argv[]) {
    if (argc != 6) {
        fprintf(stderr, "usage: ./app serve --port <n> --workers <n>\n");
        exit(1);
    }
    Serve *s = (Serve *)ctx;
    s->port    = atoi(argv[3]);
    s->workers = atoi(argv[5]);
}

void parse_migrate(void *ctx, int argc, char *argv[]) {
    if (argc != 6) {
        fprintf(stderr, "usage: ./app migrate --dsn <s> --dry_run <0/1>\n");
        exit(1);
    }
    Migrate *m = (Migrate *)ctx;
    m->dsn     = argv[3];
    m->dry_run = atoi(argv[5]);
}

void parse_ping(void *ctx, int argc, char *argv[]) {
    if (argc != 6) {
        fprintf(stderr, "usage: ./app ping --host <s> --timeout <d>s\n");
        exit(1);
    }
    Ping *p = (Ping *)ctx;
    p->host      = argv[3];
    p->timeout_s = atoi(argv[5]);
}
```

---

## Handlers

```c
void serve(void *ctx) {
    Serve *s = (Serve *)ctx;
    printf("serve: port=%d workers=%d\n", s->port, s->workers);
}

void migrate(void *ctx) {
    Migrate *m = (Migrate *)ctx;
    printf("migrate: dsn=%s dry_run=%d\n", m->dsn, m->dry_run);
}

void ping(void *ctx) {
    Ping *p = (Ping *)ctx;
    printf("ping: host=%s timeout_s=%d\n", p->host, p->timeout_s);
}
```

---

## `main` — loop de despacho

```c
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("usage: ./app <command>\n");
        return 1;
    }

    // Defaults — parse sobreescribe solo si el usuario pasó argumentos
    Serve   s = { .port = 8080, .workers = 1 };
    Migrate m = { .dsn  = "",   .dry_run  = 0 };
    Ping    p = { .host = "",   .timeout_s = 5 };

    Command commands[] = {
        { .fn = serve,   .name = "serve",   .parse = parse_serve,   .ctx = &s },
        { .fn = migrate, .name = "migrate", .parse = parse_migrate, .ctx = &m },
        { .fn = ping,    .name = "ping",    .parse = parse_ping,    .ctx = &p },
    };

    const char *command = argv[1];
    size_t      len     = sizeof(commands) / sizeof(commands[0]);

    for (size_t i = 0; i < len; i++) {
        if (strcmp(command, commands[i].name) == 0) {
            commands[i].parse(commands[i].ctx, argc, argv);
            commands[i].fn(commands[i].ctx);
            return 0;
        }
    }

    printf("error: unknown command '%s'\navailable: serve, migrate, ping\n", command);
    return 1;
}
```

```bash
clang -Wall -Wextra -Werror -g -fsanitize=address,undefined -o app app.c
./app serve --port 9000 --workers 8
```

---

## Extensibilidad — agregar un subcomando nuevo

El loop central **nunca se toca**. Agregar un subcomando es siempre exactamente esto:

```c
// 1. Struct de config
typedef struct { ... } NewCmdConfig;

// 2. Dos funciones
void parse_newcmd(void *ctx, int argc, char *argv[]) { ... }
void newcmd(void *ctx) { ... }

// 3. Una línea en la tabla
{ .fn = newcmd, .name = "newcmd", .parse = parse_newcmd, .ctx = &cfg }
```

---

## Evolución del código — bugs encontrados en el camino

|Iteración|Bug|Causa raíz|Fix|
|---|---|---|---|
|v1|Segundo if-else para construir ctx|Tabla sin ctx — el dispatch no era completo|Mover parseo a una `ParseFn` dentro del struct|
|v2|`argv[3]` accedido antes de validar argc|Ctx construido antes del match → UB|Parseo on-demand dentro del loop|
|v3|`NULL` pasado a `%s` (`dry_run = 0` como `char *`)|Tipo incorrecto para un flag booleano|`int dry_run` en lugar de `char *`|
|v4 ✓|—|—|Arquitectura completa|

---

## Reglas aprendidas

|Regla|Detalle|
|---|---|
|La tabla es la única fuente de verdad|Si necesitas un segundo loop o if-else, la tabla está incompleta|
|Parseo on-demand|Nunca acceder a `argv[N]` antes de validar que `argc > N`|
|Errores a `stderr`|`fprintf(stderr, ...)` + `exit(1)` — convención de CLI Unix|
|Tipos modelan semántica|Un flag booleano es `int`, no `char *`|
|Fallo ruidoso > fallo silencioso|`return` silencioso en parse confunde al usuario|

---

## `argc` y `argv` — referencia rápida

```bash
./app serve --port 8080
```

|índice|valor|
|---|---|
|`argv[0]`|`"./app"` — siempre el nombre del binario|
|`argv[1]`|`"serve"`|
|`argv[2]`|`"--port"`|
|`argv[3]`|`"8080"`|
|`argc`|`4`|

- `argv[argc]` siempre es `NULL` — sentinel garantizado por el estándar
- Comparar strings: `strcmp(a, b) == 0` de `<string.h>`
- Convertir string a int: `atoi(argv[n])` de `<stdlib.h>`

---

## Conexión con sistemas reales

Este patrón es el núcleo de `kubectl`, `docker`, `git`:

```
git commit  →  dispatch  →  parse_commit(ctx, argc, argv)  →  cmd_commit(ctx)
git push    →  dispatch  →  parse_push(ctx, argc, argv)    →  cmd_push(ctx)
```

El loop central no cambia nunca — solo crece la tabla.

---

_Compilador: clang en macOS Apple Silicon_ _Flags: `-Wall -Wextra -Werror -g -fsanitize=address,undefined`_

[[Clase 4 — typedef y Punteros a Función]] [[Clase 5 — Structs, Forward Declarations y Encapsulación]]
---
## Próxima clase

[[Clase 5 — Structs, Forward Declarations y Encapsulación]]

- `struct` con forward declarations
- Punteros opacos — esconder implementación detrás de una API
- El equivalente en C de encapsulación

---

_Compilador: clang en macOS Apple Silicon_ _Flags: `-Wall -Wextra -Werror -g -fsanitize=address,undefined`_