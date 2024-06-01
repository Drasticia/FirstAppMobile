import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import 'register_screen.dart';
import 'homescreen.dart'; // Import HomeScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _login() {
    // Handle login logic here
    print('Email: ${emailController.text}, Password: ${passwordController.text}');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/icons/logo.png', height: 100), // Adjust the asset path accordingly.
              SizedBox(height: 20),
              Text(
                'Masuk Sebagai Masyarakat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: 'Email',
                hintText: 'Masukkan email',
                controller: emailController,
              ),
              CustomTextField(
                labelText: 'Password',
                hintText: 'Masukkan password',
                controller: passwordController,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa password?',
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Masuk',
                onPressed: _login,
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Belum mempunyai akun? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Daftar di sini',
                      style: TextStyle(color: Theme.of(context).hintColor),
                      recognizer: _tapRecognizer
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
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
}
