<h3>Fundamentos de gRPC and protocol buffers</h3>

1. Qué es gRPC
2. REST vs gRPC vs RPC vs GraphQL
		1. Contratos
		2. Versionados
	2. HTTP/2 y arquitectura
		1. Multiplexing
		2. Formato en binario
		3. Stream de datos
		4. Server push
3. Ciclo de vida de RPC
		1. Unary
		2. Client Streaming
		3. Server Streaming
		4. Bidirectional streaming
		5. Ejemplos ilustrativos de cada uno
			1. Unary
				1. ```Tenemos una aplicación de línea de comandos que consulta el estado de un servicio. El cliente realiza una llamada unary a un RPC de _health check_ expuesto por el servidor. El servidor recibe la solicitud y ejecuta una verificación puntual:
					1. Confirma que el proceso sigue en ejecución
					2. Verifica que sus dependencias están disponibles
					3. Valida la conexión con la base de datos
				Una vez completadas las verificaciones, el servidor responde con un único mensaje indicando el estado del servicio (healthy o unhealthy) y finaliza el RPC.
				   ```
			2. Client Streaming
				1. ``` Tenemos una aplicación que aplica efectos a la voz. El cliente comienza a grabar audio durante 20 segundos. Cada segundo, captura un fragmento de audio y lo envía al servidor como parte de un stream. Cuando termina la grabación, el cliente **cierra explícitamente el stream de envío**. El servidor recibe todos los fragmentos de audio, los procesa en conjunto para aplicar el efecto solicitado y, una vez finalizado el procesamiento, devuelve **un único archivo de audio completo** al cliente.
				   ```
			3. Server Streaming
				1. `El cliente solicita al servidor las métricas del servicio durante un intervalo de 10 segundos. El servidor recibe la solicitud y abre un stream de respuesta. Cada segundo, el servidor envía al cliente un mensaje con las métricas actuales del sistema, como: 
				 `1. Uso de CPU
				 `2. Uso de memoria
				 `3. Endpoint o procedimiento más demandado
				 `Una vez transcurridos los 10 segundos, el servidor **cierra explícitamente el stream**. El cliente detecta el cierre del stream y finaliza su ciclo de lectura.`.
			4. Bidirectional Streaming
				1. `Tenemos una aplicación que gestiona invitaciones de graduación por grupo. El cliente abre una conexión gRPC bidireccional con el servidor y comienza a **enviar los alumnos del grupo 7°B uno por uno**. Por cada alumno recibido, el servidor: 
				 `1. Verifica si sigue cursando
				 `2. Verifica si tiene el boleto pagado. 
				 `Inmediatamente después de validar a cada alumno, el servidor **responde en el mismo stream** notificando al administrador: Si la invitación fue enviada correctamente o si no se envió, indicando el motivo (baja o falta de pago). Mientras el cliente sigue enviando alumnos, el servidor continúa respondiendo, sin esperar a que termine la lista completa.
4. Protocol buffers
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
				1. Unary
				2. Client streaming.
				3. Server Streaming.
				4. Bidirectional Streaming.
			2. Definición de options
		6. Compatibilidad
			1. Eliminacion de campos
			2. Campos reservados
5. Ejercicios
	1. Definir un problema para elegir entre REST, gRPC, etc.
		1. ``
	2. Definir un problema abstracto para la definición de contrato.
			1. ```**Diseño de un servicio de ejecución de tareas**
			Se requiere diseñar el contrato de un servicio remoto que permita a distintos clientes interactuar con un sistema encargado de ejecutar tareas de forma asíncrona.
			El servicio debe permitir:
			`1. Crear una tarea individual y obtener su estado inicial.
			`2. Enviar múltiples tareas de forma eficiente en una sola sesión
			`3. Observar el progreso y los cambios de estado de una tarea en tiempo real.
			`4. Interactuar activamente con la ejecución de una tarea mientras está en curso, puedes iniciar, pausar, reaundar, cancelar.
			El objetivo de este ejercicio **no es implementar la lógica del sistema**, sino **diseñar contratos gRPC claros, coherentes y evolutivos**, eligiendo correctamente el tipo de RPC adecuado para cada interacción.
	3. Un cuestionario para confirmar conceptos




