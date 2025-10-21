<h1 align="center">🧸 login_with_animation</h1>

<p align="center">
  <i>A Flutter login screen featuring an interactive Rive bear animation 🐻</i>
</p>

---

## 📝 Short Description
**login_with_animation** is a Flutter application that presents an animated login screen using **Rive**.  
The animation features a bear that reacts in real time to user actions, turning the login process into a fun and engaging experience.

---

## ⚙️ Main Features
- 🐻 The bear **follows the user’s typing** while entering the email.  
- 🙈 When typing the password, the bear **covers its eyes**.  
- ✅ If both the email and password meet the validation criteria (email regex, and password with at least 8 characters, one uppercase, one number, and one special symbol), a **success animation** plays.  
- ❌ Otherwise, a **failure animation** is displayed.

---

## 🎨 What is Rive and What is a State Machine?
**Rive** is a powerful tool for creating real-time, interactive animations that respond to app logic.  
A **State Machine** in Rive controls transitions between animations based on logic and input events.  

In this project, the State Machine **"Login Machine"** manages the bear’s animations and reactions throughout the login process.

---

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



<h2 align="center">🧩 Project Structure</h2>

<pre>
lib/
├── main.dart
└── screens/
    └── login_screen.dart

assets/
└── animated_login_character.riv
</pre>

---

<h2 align="center">🎥 Demo</h2>

<p align="center">
  <img src="https://i.postimg.cc/02fM48yb/Email-bear-animated.gif" 
       alt="Login demo" 
       width="420" 
       style="border-radius:10px;"/>
</p>

<p align="center">
  <img src="https://i.postimg.cc/c1Tdy6f8/Password-bear-animated-Hechocon-Clipchamp-ezgif-com-video-to-gif-converter.gif" 
       alt="Login demo" 
       width="420" 
       style="border-radius:10px;"/>
</p>

<p align="center">
  <img src="https://i.postimg.cc/Jhdd5VXD/Success-bear-animated-Hechocon-Clipchamp-ezgif-com-video-to-gif-converter.gif" 
       alt="Login demo" 
       width="420" 
       style="border-radius:10px;"/>
</p>

---

<h2 align="center">🎓 Academic Information</h2>

<p align="center">
  <b>Subject:</b> Graficación <br>
  <b>Instructor:</b> Rodrigo Fidel Gaxiola Sosa
</p>

---

<h2 align="center">🙌 Credits</h2>

<p align="center">
  Original animation: 
  <a href="https://rive.app/marketplace/3645-7621-remix-of-login-machine/" target="_blank">
    <b>Remix of Login Machine</b>
  </a><br>
  Created and published on 
  <a href="https://rive.app/marketplace/" target="_blank">
    <b>Rive Marketplace</b>
  </a>.
</p>

---

<p align="center">
  <b>✨ Made with Flutter, Dart & Rive ✨</b>
</p>



