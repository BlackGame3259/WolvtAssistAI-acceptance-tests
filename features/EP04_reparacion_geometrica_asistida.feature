# language: es
# Epic: EP04 - Reparación y Optimización Geométrica Asistida
# Producto: WolvtAssist AI
# Relacionado con: US20, US21, US22, US23, US24, US25, US26

Característica: Reparación y optimización geométrica asistida por IA
  Como estudiante o ingeniero que trabaja con modelos CAD/CAE
  Quiero que la plataforma detecte y corrija errores geométricos
  Para evitar fallos en la malla y en el análisis estructural/físico

  # US20 - Resaltado de líneas duplicadas
  Escenario: Detección y resaltado visual exitoso de líneas duplicadas
    Dado que el diagnóstico topológico finalizó
    Cuando la IA detecta aristas superpuestas
    Entonces debe iluminar dichas aristas en rojo brillante en el visor 3D

  Escenario: Incapacidad de renderizar el resaltado de líneas duplicadas
    Dado que el diagnóstico topológico finalizó
    Cuando la IA detecta aristas superpuestas pero el hardware del usuario presenta un error gráfico en el visor 3D
    Entonces el sistema debe listar textualmente el ID o coordenadas de las líneas duplicadas en el panel de diagnóstico para que el usuario pueda identificarlas

  # US21 - Detección de caras abiertas
  Escenario: Identificación exitosa de caras abiertas
    Dado que el modelo es un cuerpo sólido
    Cuando la IA detecta una fuga geométrica (cara abierta)
    Entonces debe sombrear el borde abierto en color naranja alertando sobre la anomalía

  Escenario: Imposibilidad de detectar el volumen base
    Dado que el usuario importa un archivo CAD incompleto o corrupto
    Cuando el modelo tiene demasiadas caras faltantes y no puede ser interpretado como un sólido base
    Entonces el sistema debe mostrar un error crítico de "Geometría irreconocible" y solicitar una re-importación

  # US22 - Auto-reparar nodos (con Data Table / Esquema del escenario)
  Esquema del escenario: Fusión automática de nodos según distancia de separación
    Dado que el asistente detectó nodos desconectados a <distancia_mm> mm
    Cuando el ingeniero presiona "Auto-reparar"
    Entonces el sistema debe "<resultado>"

    Ejemplos:
      | distancia_mm | resultado                                                                             |
      | 0.005        | colapsar los nodos en uno solo y actualizar la geometría                             |
      | 0.01         | colapsar los nodos en uno solo y actualizar la geometría                             |
      | 0.3          | colapsar los nodos en uno solo y actualizar la geometría                             |
      | 0.5          | cancelar la fusión automática y recomendar el cierre manual para evitar deformación   |
      | 1.2          | cancelar la fusión automática y recomendar el cierre manual para evitar deformación   |

  # US23 - Simplificación estética (Defeaturing)
  Escenario: Sugerencia de simplificación exitosa
    Dado que el modelo incluye barrenos o filetes menores a 2mm
    Cuando la IA analiza la complejidad
    Entonces debe sugerir un "Defeaturing" (simplificación) para ignorarlos en la malla

  Escenario: Ausencia de elementos estéticos a simplificar
    Dado que la IA escanea la complejidad del modelo estructural
    Cuando no detecta barrenos, chaflanes o filetes de tamaño insignificante para el cálculo
    Entonces el panel de diagnóstico debe indicar "Ninguna simplificación estética recomendada" con un check verde

  # US24 - Control manual de reparación
  Escenario: Rechazo manual de una modificación
    Dado que la IA presenta una lista de 3 correcciones
    Cuando el estudiante presiona la "X" en una de ellas
    Entonces el sistema debe ignorar esa sugerencia y mantener esa parte del modelo intacta

  Escenario: Riesgo inminente al rechazar corrección crítica
    Dado que la IA presenta una lista de correcciones geométricas
    Cuando el estudiante presiona la "X" en un error crítico (como caras abiertas)
    Entonces el sistema debe mostrar una advertencia secundaria indicando que "Rechazar esta corrección provocará fallos directos en el mallado"

  # US25 - Resumen de reparaciones
  Escenario: Visualización detallada del resumen de correcciones
    Dado que el usuario aplicó correcciones automáticas
    Cuando despliega la pestaña "Resumen Geométrico"
    Entonces debe ver un listado indicando cuántas líneas, caras o nodos fueron modificados

  Escenario: Resumen sin modificaciones
    Dado que el usuario inspecciona el modelo inicial
    Cuando despliega la pestaña "Resumen Geométrico" sin haber aplicado ninguna reparación o simplificación
    Entonces el listado debe mostrar "0 modificaciones realizadas" en todas las categorías

  # US26 - Deshacer corrección rápida
  Escenario: Reversión de la última reparación
    Dado que el usuario aceptó una corrección geométrica
    Cuando presiona el botón "Deshacer" (o Ctrl+Z)
    Entonces el modelo debe volver a su estado inmediatamente anterior

  Escenario: Intento de deshacer tras iniciar el mallado
    Dado que el usuario aplicó correcciones geométricas y procedió a generar la malla volumétrica
    Cuando intenta presionar "Deshacer" (o Ctrl+Z)
    Entonces el sistema debe bloquear la acción, requiriendo que primero se limpie la malla generada antes de poder revertir la geometría
