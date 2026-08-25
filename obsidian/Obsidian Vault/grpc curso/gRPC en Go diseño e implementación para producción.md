## gRPC en Go: diseño e implementación para producción

**Objectivo**
El curso busca que el alumno entienda **cuándo y por qué usar gRPC**, cómo diseñar contratos estables con Protocol Buffers y cómo construir sistemas backend listos para producción usando gRPC como mecanismo de comunicación.

**Audiencia**
Este curso esta dirigido a personas con experiencia desarrollando servicios backend en Go y APIs REST.

**Bloques**
***Bloque 0 - Preparación y metodología del curso.***
Preparar el entorno técnico del alumno y explicar la dinámica del curso para que pueda concentrarse en aprender gRPC sin fricciones técnicas.
1. Introduccion al curso
	1. Bienvenida
	2. Como está estructurado al curso
	3. Como hacer preguntas en Udemy
		1. Qué informacion incluir
		2. Ejemplo de buenas preguntas técnicas
2. Configurado el entorno de desarrollo
	1. Instalación de Go
	2. Instalación de protoc
	3. Instalación de plugins de gRPC
		1. `protoc-gen-go`
		2. `proto-gen-go-grpc
	4. Editor de codigo
		1. Visual studio code
			1. Extensiones recomendas
		2. Zed
			1. Plugins necesarios
	5. Cliente para probar RPCs
		1. Insomnia
		2. Evans
***Bloque 1 -  Fundamentos de gRPC y Protocol Buffers***
El alumno aprenderá por qué existe gRPC, que tipo de RPC se necesita para X problema y como definir contractos con protocol buffers.
3. Fundamentos de gRPC and protocol buffers
	1. Qué es gRPC
	2. REST vs gRPC vs RPC vs GraphQL
		1. Contratos
		2. Versionados
	3. HTTP/2 y arquitectura
		1. Multiplexing
		2. Formato en binario
		3. Stream de datos
		4. Server push
	4. Ciclo de vida de RPC
		1. Unary
		2. Client Streaming
		3. Server Streaming
		4. Bidirectional streaming
		5. Ejemplos ilustrativos de cada uno
	5. Protocol buffers
		1. Protoc
			1. Instalacion de protoc
			2. Que es un archivo protoc
			3. syntax proto2 y proto3
		2. Definición de mensajes
			1. Tipos de datos
			2. Field numbers
			3. Valores por defecto
			4. Enumeraciones
				1. Comportamiento
		3. Mensajes embebidos
		4. Importación de mensajes
		5. Servicios
			1. Definición de services
			2. Definición de options
		6. Compatibilidad
			1. Eliminacion de campos
			2. Campos reservados
	6. Ejercicios
		1. Definir un problema abstracto para la definicion de contrato.
		2. Definir un problema para elegir entre REST, gRPC, etc.
		3. Un cuestionario para confirmar conceptos
***Bloque 2 - Diseño y evolución de Protocol Buffers***
Al finalizar este bloque el alumno será capaz de:
- Diseñar contratos **estables y evolutivos** en Protocol Buffers
- Identificar cambios que rompen compatibilidad
- Tomar decisiones conscientes considerando **cualquier lenguaje consumidor**
- Aplicar buenas prácticas reales de producción para evitar incidentes por cambios en `.proto`
2. Protocol Buffers
	1. Modelado de dataos avanzado
		1. Any 
		2. oneOf 
		3. maps 
		4. packages 
	2. Extensiones
		1. Use verification = Declaration
	3. Servicios
		1. Servicios, metodos RPC
		2. Optiones
	4. generar clases con protoc
	5. Guía de estilos
		1. - Uso de comillas dobles en strings
		2. Cómo documentar un archivo `.proto`
		3. Nombres de paquetes
		4. Nombrado correcto de mensajes
		5. Enums
			1. Extender valores de una enumeración existente
			2. Retención de opciones
		6. Nombres correctos para servicios y RPCs
		7. Evitar campos `required` o reservados del framework
	6. Buenas practicas
		1. Nunca reutilizar tag numbers
		2. Reservar campos antes de ser eliminados
		3. Reserver valores para ENUM
			1. Como de deprecar un ENUM viejo con otro nuevo
		4. No agregar demasiados campos a los mensajes
		5. Agregar valores por defecto a ENUM
	7. Ejercicio
		1. Dado un contracto con pesimas practicas, mejorarlo correctamente
		2. Quiz o cuestionario

***Bloque 3 Implementación de servicios gRPC en Go (nivel producción)***
Al finalizar este bloque, el alumno será capaz de diseñar e implementar servicios gRPC en Go listos para producción, comprendiendo el ciclo de vida completo de los distintos tipos de RPC y aplicando correctamente conceptos fundamentales y avanzados como manejo de errores, interceptores, cancelaciones, metadata, autenticación y observabilidad, con el fin de construir sistemas eficientes, robustos y mantenibles.
3. Ciclo de RPC
	1. Unary
	2. Client streaming
	3. Server streaming
	4. Bidirectional
	5. Ejercicios
		1. Dado un problema, decidir qué tipo de RPC usar y por qué
		2. Implementar los cuatro tipos sobre el mismo servicio base
4. Manejo de errors
	1. Manejo de google.golang.org/grpc/codes 
	2. Manejo de  google.golang.org/grpc/status
	3. Diferencia entre:
		1. error de validación
		2. error de negocio
		3. error transitorio
		4. error fatal
	4. Ejercicio
		1. Se presentan escenarios reales:
			1. recurso no encontrado
			2. timeout
			3. permiso denegado
			4. input inválido
		- Elegir **status code correcto** y justificarlo
5. Incerceptores
	1. Interceptores cliente
	2. Incerceptores servidor
	3. Chain Interceptors
		1. Interceptor cliente:
			1. logging
			2. retry controlado
		2. Interceptor servidor:
			1. logging estructurado
			2. métricas
			3. auth básico
6. Cancelaciones
	1. Crear cancelacion y porqué crearla, para qué sirve
7. Metadata
	1. Qué es metadata
	2. Cuándo usarla
	3. Metadata entrante vs saliente
		1. Pasar información de tracing / auth vía metadata
8. Autenticación
	1. SSL/TLS
	2. ALTS (explicar _cuándo sí_, no solo cómo)
	3. mTLS
	4. JWT
		1. envío por metadata
		2. validación en interceptor
9. Qué es observabilidad en sistemas distribuidos
	1. OpenTelemetry + gRPC
	2. Métricas por tipo de RPC:
		1. Unary
		2. Server Streaming
		3. Client Streaming
		4. Bidirectional
	3. Ejercicio
		1. Instrumentar el servicio
		2. Visualizar métricas básicas
		3. Entender impacto de streams largos
***Bloque 4 - Pruebas unitarias a servicios de gRPC***
Al finalizar este bloque, el alumno será capaz de diseñar y ejecutar pruebas unitarias y benchmarks para servicios gRPC en Go, utilizando únicamente la librería estándar, comprendiendo cómo aislar la lógica del servicio, probar correctamente los distintos tipos de RPC y medir el impacto real en rendimiento.
10. Pruebas unitarias
	1. Unary
	2. Server Streaming
	3. Client Streaming
	4. Bidirectional Streaming
11. Benchmarks
	1. Unary
	2. Server Streaming
	3. Client Streaming
	4. Bidirectional Streaming
***Bloque 5 - gRPC en Kubernetes***
Entender cómo se configuran **timeouts, retries y balanceo** en gRPC, qué responsabilidad tiene el cliente y cuál el servidor, y evitar configuraciones peligrosas comunes.
12. Empaquetado del servicio (Docker)
	1. Create el artifact registry repo
13. Despliegue mínimo en Kubernetes
	1. Crear el cluster
	2. Crear Service
	3. Crear deployment
14. DNS y resolución de servicios
	1. Como los servicios se descruben entre sí
	2. DNS Interno de kubernetes
	3. Como gRPC resuelve endpoints
15. Load balancing gRPC
	1. pick_first
	2. round_robin
	3. Demostración con multiples replicas.
16. Timeouts y fallos reales
	1. qué ocurre cuando un pod falla  
	2. Reconexión automática  
	3. Cómo gRPC maneja conexiones caídas  
	4. Uso correcto de context.WithTimeout
***Bloque 6 - gRPC y Web*
Entender por qué gRPC **no es una tecnología para navegadores**, qué alternativas existen y cómo exponer servicios gRPC hacia el mundo web **sin romper el diseño interno**.
18. Por qué gRPC no corre nativamente en navegadores
19. HTTP/2 vs HTTP/1.1 en browsers
20. Limitaciones del runtime del navegador
21. gRPC vs gRPC-Web
22. Por qué **NO** debes exponer gRPC interno directo al frontend
23. Exponer gRPC vía HTTP usando grpc-gateway
24. Qué es grpc-gateway y qué **no es**
	1. Casos de uso correctos
	2. Instalación de grpc-gateway
	3. Modificación de contratos (`google.api.http`)
	4. Generación del gateway
	5. Consumo con CURL
***Bloque 7 - Uso de buf*
Aprender a gestionar `.proto` como **artefactos versionados**, con validaciones automáticas y compatibilidad controlada.
25. Qué es Buf
26. Qué problema existe con `protoc`
27. Buf como herramienta de:
	1. lint
	2. breaking changes
	3. generación reproducible
28. Configuración básica de Buf
	1. `buf.yaml`
	2. `buf.gen.yaml`
	3. Integración con `protoc`
29. Linting de contratos
30. Detección de breaking changes
31. Ejemplo de cambio que falla

***Bloque 8 - Despedida***
Aquí comparto recursos extras para la profundizacion de gRPC tales como la serializacion y deserializacion a nivel binario







