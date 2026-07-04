# language: es
# Epic: EP10 - Rendimiento, Seguridad y Usabilidad (No Funcionales)
# Producto: WolvtAssist AI
# Relacionado con: US55, US56, US57, US58 (4 historias de usuario no funcionales)

Característica: Rendimiento, seguridad y usabilidad no funcional de la plataforma
  Como estudiante o ingeniero que utiliza WolvtAssist AI en equipos de recursos limitados
  Quiero que la plataforma garantice rendimiento, seguridad y disponibilidad
  Para poder confiar en la herramienta en cualquier contexto académico o profesional

  # US55 (No Funcional) - Procesamiento intensivo en la nube
  Escenario: Delegación correcta de carga computacional
    Dado que se inicia un escaneo preventivo o un cálculo de malla altamente complejo
    Cuando el usuario revisa el rendimiento local de su computadora (Administrador de tareas)
    Entonces el consumo de CPU o RAM del navegador ejecutando WolvtAssist AI no debe superar el 15%

  Escenario: Fallo de servidor y salvaguarda de datos
    Dado que el servidor en la nube se encuentra realizando un cálculo intensivo
    Cuando ocurre una interrupción de red por parte del usuario
    Entonces el servidor debe continuar ejecutando el cálculo y enviar un correo electrónico al usuario cuando el resultado esté listo, sin cancelar el proceso por desconexión local

  # US56 (No Funcional) - Tiempo de carga y respuesta (con Data Table / Esquema del escenario)
  Esquema del escenario: Tiempo de renderizado según tamaño y complejidad del archivo
    Dado que el usuario sube un archivo CAD de <tamano_mb> MB mediante una conexión estable
    Cuando la barra de subida alcanza el 100%
    Entonces el visor 3D debe comportarse como "<resultado>" en un tiempo de <tiempo_seg> segundos

    Ejemplos:
      | tamano_mb | tiempo_seg | resultado                                                                    |
      | 10        | 5          | modelo totalmente interactivo                                                |
      | 30        | 11         | modelo totalmente interactivo                                                |
      | 50        | 15         | modelo totalmente interactivo                                                |
      | 45        | 22         | mensaje "Modelo de alta densidad detectado, optimizando renderizado..."     |

  # US57 (No Funcional) - Seguridad y encriptación de diseños
  Escenario: Encriptación estándar durante la transferencia
    Dado que el usuario realiza transferencias de archivos hacia la nube
    Cuando los datos (archivos CAD o resultados) viajan a través de la red
    Entonces deben estar protegidos obligatoriamente mediante el protocolo de seguridad HTTPS/TLS 1.3 (o superior)

  Escenario: Bloqueo de transferencia por red local insegura
    Dado que el usuario intenta subir un modelo con propiedad intelectual desde un laboratorio compartido o red pública
    Cuando el sistema detecta que la red no cumple con el protocolo de seguridad SSL
    Entonces la plataforma debe bloquear automáticamente la subida y mostrar una alerta de "Conexión no segura. Riesgo de privacidad."

  # US58 (No Funcional) - Alta disponibilidad del sistema
  Escenario: Acceso garantizado sin interrupciones en horario nocturno
    Dado que un estudiante intenta acceder a la plataforma a las 3:00 a.m. para un trabajo final
    Cuando introduce sus credenciales
    Entonces el sistema debe estar completamente operativo, cumpliendo el SLA de menos de 8 horas de caída acumulada por año

  Escenario: Activación de servidor de respaldo (Failover)
    Dado que el servidor primario de la nube sufre una caída generalizada
    Cuando el estudiante se encuentra utilizando la plataforma
    Entonces el tráfico debe redirigirse automáticamente a un servidor secundario en menos de 5 segundos, mostrando solo un breve aviso de "Sincronizando conexión" sin cerrar la sesión del usuario
