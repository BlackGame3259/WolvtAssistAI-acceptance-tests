# language: es
# Epic: EP05 - Asistencia Inteligente y Automatización de Mallado
# Producto: WolvtAssist AI
# Relacionado con: US27, US28, US29, US30, US31, US32, US33, US34, US35

Característica: Asistencia inteligente y automatización de mallado
  Como estudiante o ingeniero que prepara una simulación
  Quiero que la plataforma me asista en la generación y validación de la malla
  Para obtener resultados de simulación precisos sin saturar mi equipo

  # US27 - Sugerencia tamaño base (mm)
  Escenario: Cálculo de tamaño óptimo exitoso
    Dado que la geometría está validada
    Cuando el estudiante entra al módulo de malla
    Entonces la IA debe calcular y rellenar automáticamente el campo "Tamaño de Elemento" con un valor óptimo

  Escenario: Advertencia de escala inusual
    Dado que la geometría está validada
    Cuando el estudiante entra al módulo de malla y las dimensiones del modelo exceden los cientos de metros o son del nivel de micras
    Entonces la IA debe alertar sobre "Escala inusual detectada" y solicitar al usuario verificar las unidades antes de sugerir el tamaño de malla

  # US28 - Sugerencia malla tetraédrica
  Escenario: Recomendación de elementos tetraédricos
    Dado que el volumen del modelo es altamente curvo o irregular
    Cuando la IA emite sus recomendaciones
    Entonces debe sugerir "Malla Tetraédrica" como primera opción para asegurar la convergencia

  Escenario: Forzado manual de configuración contraproducente
    Dado que el sistema recomendó malla tetraédrica para una pieza orgánica compleja
    Cuando el usuario ignora la recomendación y fuerza una malla hexaédrica pura
    Entonces el generador de malla intentará discretizar pero arrojará un error de "Fallo topológico" y revertirá al estado original

  # US29 - Sugerencia malla hexaédrica
  Escenario: Recomendación de elementos hexaédricos
    Dado que el modelo está compuesto mayoritariamente por formas prismáticas (vigas/columnas)
    Cuando la IA analiza la forma
    Entonces debe sugerir el uso de "Elementos Hexaédricos" para optimizar el cálculo

  Escenario: Detección mixta (Multizona)
    Dado que el modelo civil incluye una combinación de vigas simples y uniones curvas complejas
    Cuando la IA analiza el cuerpo completo
    Entonces debe recomendar una estrategia "Multizona", aplicando hexaedros en los prismas y tetraedros en las intersecciones curvas

  # US30 - Alerta preventiva de RAM (con Data Table / Esquema del escenario)
  Esquema del escenario: Alerta de saturación de memoria según nodos proyectados
    Dado que el usuario define un tamaño de malla manual que proyecta <nodos_estimados> nodos
    Cuando el cálculo proyectado de consumo de RAM equivale a <ram_estimada_gb> GB
    Entonces el sistema debe "<resultado>"

    Ejemplos:
      | nodos_estimados | ram_estimada_gb | resultado                                                                         |
      | 500000          | 2               | permitir la generación de la malla sin advertencias                              |
      | 2000000         | 6               | permitir la generación de la malla sin advertencias                              |
      | 5000000         | 8               | emitir una alerta roja bloqueando temporalmente la generación                     |
      | 12000000        | 15              | emitir una alerta roja bloqueando temporalmente la generación                     |

  Escenario: Forzado manual con límite de seguridad
    Dado que el usuario recibió la alerta roja
    Cuando el usuario aprueba explícitamente el riesgo y presiona "Continuar de todos modos"
    Entonces el sistema debe iniciar el mallado pero suspenderlo automáticamente si la RAM del navegador alcanza un límite crítico (ej. 95%), salvaguardando el equipo

  # US31 - Refinamiento local curvo
  Escenario: Aplicación exitosa de refinamiento local
    Dado que el usuario acepta las sugerencias de mallado base
    Cuando el motor genera la malla volumétrica
    Entonces debe aplicar un tamaño de elemento menor (mesh sizing) específicamente en todos los radios, filetes y agujeros detectados

  Escenario: Exceso de micro-curvaturas detectadas
    Dado que el modelo posee un exceso de texturas rugosas o micro-curvas
    Cuando la IA intenta aplicar el refinamiento local y proyecta un aumento desproporcionado de nodos
    Entonces debe cancelar el refinamiento automático, aplicar la malla base y sugerir al usuario una "Simplificación estética" primero

  # US32 - Alerta malla distorsionada
  Escenario: Detección y alerta de elementos de baja calidad
    Dado que la malla se ha generado completamente
    Cuando el algoritmo detecta un "Jacobiano" negativo o elementos con una relación de aspecto (aspect ratio) inaceptable
    Entonces debe resaltarlos en color amarillo en el visor indicando "Calidad de elemento baja"

  Escenario: Malla irrecuperable por topología base
    Dado que la malla generada resulta con más del 30% de sus elementos distorsionados
    Cuando el sistema finaliza la evaluación de calidad
    Entonces debe mostrar un error crítico rojo indicando "Malla no apta para cálculo" y bloquear el pase a la fase de simulación hasta que se repare la geometría

  # US33 - Previsualización de la malla
  Escenario: Renderizado exitoso de la malla
    Dado que el proceso de mallado alcanza el 100%
    Cuando el usuario mira el visor central 3D
    Entonces debe visualizar la retícula (wireframe) de la malla aplicada sobre el modelo sólido con la opción de activarla/desactivarla

  Escenario: Ocultamiento automático por densidad extrema
    Dado que el proceso de mallado finaliza con éxito
    Cuando la cantidad de elementos generados supera la capacidad de renderizado fluido de la tarjeta gráfica del navegador
    Entonces el sistema debe desactivar la previsualización de la retícula por defecto y mostrar un aviso de "Modo de rendimiento activado"

  # US34 - Borrar y regenerar malla
  Escenario: Limpieza rápida de la malla
    Dado que el usuario no está satisfecho con la malla actual mostrada en el visor
    Cuando hace clic en el botón "Limpiar Malla"
    Entonces el modelo debe volver a verse como un sólido continuo sin divisiones paramétricas en menos de 2 segundos

  Escenario: Intento de borrado con simulación en curso
    Dado que el usuario ya envió la malla al solucionador (solver) y el cálculo está en proceso
    Cuando intenta hacer clic en "Limpiar Malla"
    Entonces el botón debe estar deshabilitado y mostrar un mensaje tooltip indicando "Cancele la simulación en curso para modificar la malla"

  # US35 - Guardar configuración de malla
  Escenario: Guardado exitoso de plantilla
    Dado que el ingeniero ajustó exitosamente un mallado con parámetros personalizados
    Cuando selecciona "Guardar como plantilla" e ingresa un nombre (ej. "Vigas_Estándar")
    Entonces esa configuración debe guardarse en la nube y estar disponible en un menú desplegable para proyectos futuros

  Escenario: Intento de guardado con nombre duplicado
    Dado que el usuario ajustó sus parámetros y hace clic en "Guardar como plantilla"
    Cuando ingresa un nombre que ya existe en su biblioteca personal
    Entonces el sistema debe pedir confirmación para "Sobrescribir plantilla existente" o solicitar un nombre diferente
