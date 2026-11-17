# MarvelHeroes UD3 · proyecto de partida

Base común completa de UD2 con arquitectura y pantallas de UD3 preparadas. Las marcas
`RETO UD3` señalan exactamente las piezas pendientes: operaciones SQLite, consulta
HTTPS, lectura del sensor, emisor Wi-Fi y Manifest. El receptor y el archivo generado
de Drift ya funcionan. La app arranca con catálogo y detalle; algunas acciones muestran
mensajes de reto hasta que se completen.

1. Abre esta carpeta completa en Android Studio y ejecuta `flutter pub get`.
2. Sigue los libros y el enunciado de la unidad, en orden A1, A2, A3.
3. La API ya está preparada: 563 entradas en español. El ZIP incluye URL y clave
   publicable en `config/conexion_api_UD3.json`. Ejecuta:
   `flutter run --dart-define-from-file=config/conexion_api_UD3.json`.
4. Completa la petición HTTPS del hito A2. La configuración no resuelve el reto.
   Consulta `iron_man` y `gamora`; en A3 envía `thor` entre los dos móviles.
5. `USE_SAMPLE_API=true` solo ensaya la interfaz durante una incidencia; no
   acredita conexión HTTPS. No incorpores claves secretas ni contraseñas de base.

Este ZIP procede de la solución validada de UD2. Los seis recursos gráficos
mantienen la procedencia declarada en `PROCEDENCIA.md`.
