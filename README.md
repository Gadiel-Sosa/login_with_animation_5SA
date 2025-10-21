<h1 align="center">🧸 login_with_animation</h1>

<h2 align="center"> 📝 Short Description</h2>

<p align="justify"> login_with_animation es una aplicación desarrollada en Flutter que muestra una pantalla de inicio de sesión animada utilizando Rive.
La animación está protagonizada por un oso que reacciona en tiempo real a las acciones del usuario, haciendo del proceso de inicio de sesión una experiencia divertida e interactiva.</p>

<h2 align="center"> ⚙️ Funcionalidades principales</h2>

- 🐻 El oso sigue con la mirada mientras el usuario escribe su correo electrónico.
- 🙈 Al escribir la contraseña, el oso se cubre los ojos.
- ✅ Si el correo y la contraseña cumplen con las validaciones (regex para el correo y una contraseña con al menos 8 caracteres, una mayúscula, un número y un carácter especial), se muestra una animación de éxito.
- ❌ En caso contrario, se reproduce una animación de fallo.

<h2 align="center"> 🎨 ¿Qué es Rive y qué es un State Machine?</h2>

<p align="justify"> Rive es una herramienta para crear animaciones interactivas que pueden reaccionar a la lógica del programa en tiempo real.
En Rive, un State Machine (máquina de estados) controla las diferentes animaciones y transiciones según las condiciones o eventos definidos en el código.
En este proyecto se usa el State Machine llamado "Login Machine", el cual maneja las animaciones del oso durante el proceso de inicio de sesión.</p>

<h2 align="center">💻 Technologies Used</h2>

<p align="center">
  <a href="https://flutter.dev/" target="_blank">
    <img src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white&style=for-the-badge" alt="Flutter Badge"/>
  </a>
  <a href="https://dart.dev/" target="_blank">
    <img src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white&style=for-the-badge" alt="Dart Badge"/>
  </a>
  <a href="https://rive.app/" target="_blank">
    <img src="https://img.shields.io/badge/Rive-000000?logo=rive&logoColor=white&style=for-the-badge" alt="Rive Badge"/>
  </a>
</p>


<h2 align="center"> 🧩 Estructura básica del proyecto</h2>

<pre>
lib/
├── main.dart
└── screens/
    └── login_screen.dart

assets/
└── animated_login_character.riv
</pre>

<h2 align="center"> 🎥 Demo del funcionamiento</h2>

<p align="center">
  <img src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdDNpdndvOHZ1aXo2eW1jcm9nNjgyemFjcHRnbXliajd6eG9ob3ZraiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Ie4CIIvQS0bk3zwZlM/giphy.gif" 
       alt="Login demo" 
       width="400"/>
</p>

<h2 align="center"> 🎓 Academic Information</h2>

- Subject: Graficación
- Instructor: Rodrigo Fidel Gaxiola Sosa

<h3>🙌 Credits</h3>

<p>
  Original animation: 
  <a href="https://rive.app/marketplace/3645-7621-remix-of-login-machine/" target="_blank">
    <b>Remix of Login Machine</b>
  </a><br>
  Created and published on 
  <a href="https://rive.app/marketplace/" target="_blank">
    Rive Marketplace
  </a>.
</p>


