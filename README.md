# Vantage 

<p align="left">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  </a>
  <a href="https://dart.dev">
    <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  </a>
  <a href="https://developer.android.com/">
    <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
  </a>
  <a href="https://developer.apple.com/ios/">
    <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS" />
  </a>
</p>

Vantage es un prototipo avanzado de aplicación móvil desarrollado en Flutter. Concebido inicialmente como parte de un proceso de evaluación técnica, el proyecto demuestra la implementación de interfaces de usuario complejas y la aplicación de principios de Clean Architecture para garantizar un código escalable y mantenible.

## Características y Componentes Clave

* **UI/UX Avanzada:** Implementación de vistas dinámicas y personalizadas, incluyendo módulos como `GhostSyncHub` y flujos de detalle estructurados (`DrillDetail`).
* **Diseño Responsivo:** Adaptación de la interfaz para múltiples dimensiones de pantalla en dispositivos móviles.
* **Componentización:** Uso de widgets reutilizables para mantener la consistencia visual y reducir la duplicidad de código.

## Arquitectura y Estructura del Código

El proyecto fue diseñado mentalmente bajo los principios de Clean Architecture para facilitar la escalabilidad. Sin embargo, en pro del pragmatismo y al tratarse de un prototipo técnico enfocado en UI/UX, se implementaron únicamente las capas estrictamente necesarias para el alcance actual, evitando sobreingeniería.

```text
lib/
 ├── core/          # Configuraciones globales, temas, utilidades y constantes.
 ├── domain/        # (Conceptual) Entidades y modelos de datos simulados para la UI.
 └── presentation/  # Componentes visuales (Widgets), pantallas y navegación.
