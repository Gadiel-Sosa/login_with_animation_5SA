import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart'; // NUEVO - para esperar un frame antes de disparar triggers

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Declaramos las variables necesarias
  late TextEditingController _userPasswordController;
  bool _passwordVisible = false;
  // Cerebro de la lógica de las animaciones
  StateMachineController? controller;
  // SMI State Machine Input
  SMIBool? isCheking;
  SMIBool? isHandsUp;
  SMITrigger? trigFail;
  SMITrigger? trigSuccess;
  // 2.1 Variable de recorrido de la mirada
  SMINumber? numLook;

  // Focos email y password FocusNode paso 1.1
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  // 3.2 Crear timer para detener la animación al dejar de teclear email
  Timer? _typingDebouncer;
  //Paso 4.1 Declarar controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //4.2 Errores para mostrar en la UI
  String? emailError;
  String? passwordError;

  // NUEVO: Estado de carga y validadores dinámicos
  bool isLoading = false; // NUEVO - deshabilita el botón y muestra spinner

  // NUEVO - Validación dinámica de email
  String? firstEmailError(String text) {
    final value = text.trim();
    if (value.isEmpty) return null; // no mostrar error si está vacío
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) return 'Email no válido';
    return null;
  }

  // NUEVO - Validación dinámica de contraseña
  String? firstPasswordError(String text) {
    final p = text;
    if (p.isEmpty) return 'La contraseña no puede estar vacía';
    if (p.length < 8) return 'Mínimo 8 caracteres';
    if (!RegExp(r'[A-Z]').hasMatch(p)) return 'Debe incluir una mayúscula';
    if (!RegExp(r'[a-z]').hasMatch(p)) return 'Debe incluir una minúscula';
    if (!RegExp(r'\d').hasMatch(p)) return 'Debe incluir un número';
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(p)) return 'Debe incluir un caracter especial';
    return null;
  }

  //4.3 Validadores (pueden mantenerse, aunque los nuevos reemplazan su función)
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  // NUEVO - Versión actualizada del método onLogin con corrección de doble tap
  Future<void> _onlogin() async {
    if (isLoading) return; // NUEVO - evita que se presione varias veces

    final email = emailController.text.trim();
    final password = passwordController.text;

    final eError = firstEmailError(email); // NUEVO - usa nuevo validador
    final pError = firstPasswordError(password); // NUEVO - usa nuevo validador

    setState(() {
      emailError = eError;
      passwordError = pError;
      isLoading = true; // NUEVO - activa estado de carga
    });

    // Normalizar el estado antes del trigger
    FocusScope.of(context).unfocus();
    _typingDebouncer?.cancel();
    isCheking?.change(false);
    isHandsUp?.change(false);
    numLook?.value = 50.0; // mirada neutral

    // NUEVO - Esperar un frame antes de disparar trigger (soluciona doble tap)
    await SchedulerBinding.instance.endOfFrame;

    // NUEVO - Simular "envío" de datos con un pequeño delay
    await Future.delayed(const Duration(seconds: 1));

    if (eError == null && pError == null) {
      trigSuccess?.fire(); // NUEVO - trigger éxito
    } else {
      trigFail?.fire(); // NUEVO - trigger fallo
    }

    if (mounted) {
      setState(() {
        isLoading = false; // NUEVO - reactivar botón después del envío
      });
    }
  }

  // Listeners oyentes
  @override
  void initState() {
    super.initState();
    _userPasswordController = TextEditingController();
    _passwordVisible = false;

    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        isHandsUp?.change(false);
        isCheking?.change(false);
        numLook?.value = 50.0;
      }
    });

    passwordFocus.addListener(() {
      isHandsUp?.change(passwordFocus.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    if (controller == null) return;
                    artboard.addController(controller!);
                    isCheking = controller!.findSMI('isChecking');
                    isHandsUp = controller!.findSMI('isHandsUp');
                    trigSuccess = controller!.findSMI('trigSuccess');
                    trigFail = controller!.findSMI('trigFail');
                    numLook = controller!.findSMI('numLook');
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Campo de texto email
              TextField(
                focusNode: emailFocus,
                controller: emailController,
                onChanged: (value) {
                  // NUEVO - Validación en vivo
                  setState(() {
                    emailError = firstEmailError(value);
                  });

                  // Mirada animada
                  if (isCheking != null) {
                    isCheking!.change(true);
                    final look =
                        ((value.length / 80.0) * 100.0).clamp(0.0, 100.0).toDouble();
                    numLook?.value = look;
                  }

                  _typingDebouncer?.cancel();
                  _typingDebouncer = Timer(const Duration(seconds: 4), () {
                    if (!mounted) return;
                    isCheking?.change(false);
                    numLook?.value = 50.0;
                  });
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText: emailError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                ),
              ),

              // NUEVO - Checklist dinámico debajo del email
              if (emailController.text.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: [
                      Icon(
                        emailError == null ? Icons.check_circle : Icons.error,
                        size: 18,
                        color: emailError == null ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        emailError ?? 'Email válido',
                        style: TextStyle(
                          color: emailError == null ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              // Campo de texto password
              TextField(
                focusNode: passwordFocus,
                controller: passwordController,
                onChanged: (value) {
                  // NUEVO - Validación en vivo
                  setState(() {
                    passwordError = firstPasswordError(value);
                  });

                  if (isHandsUp != null) {
                    isHandsUp!.change(true);
                  }
                },
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  errorText: passwordError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),

              // NUEVO - Checklist dinámico debajo del password
              if (passwordController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: [
                      Icon(
                        passwordError == null ? Icons.check_circle : Icons.error,
                        size: 18,
                        color: passwordError == null ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        passwordError ?? 'Contraseña válida',
                        style: TextStyle(
                          color:
                              passwordError == null ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              SizedBox(
                width: size.width,
                child: Text(
                  'Forgot password?',
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),

              const SizedBox(height: 10),

              // NUEVO - Botón login con spinner y desactivación
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: isLoading ? null : _onlogin, // NUEVO
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No tienes cuenta?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _userPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    _typingDebouncer?.cancel();
    super.dispose();
  }
}
