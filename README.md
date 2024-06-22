# ZeroHuecos

ZeroHuecos es una aplicación móvil desarrollada en Flutter para reportar y geolocalizar baches (potholes) en tiempo real utilizando servicios de Firebase. La aplicación permite a los usuarios registrarse, iniciar sesión y añadir baches con su ubicación exacta. Además, los usuarios pueden localizar baches en un mapa y ver detalles específicos de cada bache.

## Características

- **Autenticación de Usuarios**: Registro e inicio de sesión utilizando Firebase Authentication.
- **Registro de Baches**: Añadir nuevos baches con nombre, hora y coordenadas geográficas.
- **Visualización de Baches en un Mapa**: Localizar baches en un mapa interactivo con opción de hacer zoom.
- **Detalles de Baches**: Ver información detallada de cada bache registrado.
- **Arquitectura Bloc**: Implementación de la arquitectura Bloc para la gestión de estados.

## Tecnologías Utilizadas

- [Flutter](https://flutter.dev/): Framework de desarrollo de aplicaciones móviles.
- [Firebase](https://firebase.google.com/): Backend como servicio para autenticación y almacenamiento de datos.
- [Google Maps API](https://developers.google.com/maps): Para la integración del mapa interactivo.
- [Bloc](https://bloclibrary.dev/#/): Librería para la gestión de estados en Flutter.

## Instalación

### Requisitos Previos

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Una cuenta de Firebase y un proyecto configurado.

### Pasos para la Instalación

1. **Clonar el Repositorio**
    ```sh
    git clone https://github.com/tu-usuario/ZeroHuecos.git
    cd ZeroHuecos
    ```

2. **Instalar Dependencias**
    ```sh
    flutter pub get
    ```

3. **Configurar Firebase**
    - Sigue las [instrucciones oficiales](https://firebase.google.com/docs/flutter/setup) para configurar Firebase en tu aplicación Flutter.
    - Añade los archivos `google-services.json` (Android) y `GoogleService-Info.plist` (iOS) a sus respectivas carpetas.

4. **Ejecutar la Aplicación**
    ```sh
    flutter run
    ```

## Uso

### Registro e Inicio de Sesión

1. Abre la aplicación.
2. Regístrate con un nuevo usuario o inicia sesión con uno existente.

### Añadir un Nuevo Bache

1. Navega a la pantalla principal.
2. Pulsa el botón de añadir (+).
3. Introduce el nombre del bache y añade su ubicación.
4. Guarda el bache.

### Localizar y Ver Detalles de un Bache

1. En la lista de baches, toca un bache para ver los botones "Locate" y "Detalles".
2. Pulsa "Locate" para centrar el mapa en el bache seleccionado con el nivel de zoom máximo.
3. Pulsa "Detalles" para ver información detallada del bache.

## Estructura del Proyecto

lib/
├── blocs/ # BloCs para la gestión de estados
│ ├── auth/
│ ├── pothole/
│ ├── map/
├── models/ # Modelos de datos
├── repositories/ # Repositorios para acceder a datos
├── screens/ # Pantallas de la aplicación
├── widgets/ # Widgets reutilizables
└── main.dart # Punto de entrada de la aplicación

Para cambiar la ubicación GPS en el emulador de Android
telnet localhost 5554
auth <auth_token> - La consola te muestra dónde se encuentra el Token.
geo fix -76.533699 3.399801 Casa
geo fix -76.517190 3.486501 Exito La FLora
geo fix -76.537432 3.375251 Pasoancho Panamericana
geo fix -76.520626 3.458169 Texaco La 25
geo fix -76.5209161664706 3.458161893658343 Texaco 25
geo fix -76.521225 3.453709 Tecnoquimicas
geo fix -76.5319760749882 3.454262620800837 La Ermita

## Contribuciones

¡Las contribuciones son bienvenidas! Por favor, abre un issue o un pull request para sugerencias y mejoras.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

## Contacto

Desarrollado por [Javier Charria Gómez](https://github.com/linkjavier). Si tienes alguna pregunta, no dudes en contactarme en javiercharria@gmail.com.

