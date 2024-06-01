import 'package:apptubes/screen/login_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/custom_dropdown.dart';
import '../models/firebase_auth/authentication.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  String? selectedRegion;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _postalCodeController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/icons/logo.png', height: 100), // Adjust the asset path accordingly.
              SizedBox(height: 20),
              Text(
                'Daftar Sebagai Masyarakat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: 'Nama',
                hintText: 'Masukkan nama lengkap',
                controller: _usernameController,
              ),
              CustomTextField(
                labelText: 'Email',
                hintText: 'Masukkan email',
                controller: _emailController,
              ),
              CustomTextField(
                labelText: 'Password',
                hintText: '8 Karakter dan kombinasi simbol',
                controller: _passwordController,
                obscureText: true,
              ),
              CustomDropdown(
                hintText: 'Pilih daerah tempat kamu tinggal',
                items: ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Medan'],
                value: selectedRegion,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRegion = newValue;
                  });
                },
              ),
              CustomTextField(
                labelText: 'Kode Pos',
                hintText: 'Masukkan kode pos',
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Daftar',
                onPressed: _signUp,
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Sudah mempunyai akun? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Masuk di sini',
                      style: TextStyle(color: Theme.of(context).hintColor),
                      recognizer: _tapRecognizer
                        ..onTap = () {
                          Navigator.pop(context); // Navigate back to login screen
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

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUp(email, password);

    if (user != null){
      print("Akun telah berhasil dibuat");

      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Selamat!',
          message:
          'Akun anda berhasil dibuat!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message:
          'This email is already in use, try to sign up using another email!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

}
