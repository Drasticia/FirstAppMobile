import 'package:apptubes/models/api/firebase_auth.dart';
import 'package:apptubes/screen/login_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/bottomnavbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _emailController= TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
           child: Text(
             "Masukkan email untuk penggantian kata sandi",
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 20),
           ),
         ),

         SizedBox(height: 10),
         Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Email",
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
         ),
         SizedBox(height: 10),
         MaterialButton(
             onPressed: _passwordReset,
           child: Text("Reset Password"),
           color: Colors.lightBlueAccent,
         ),
       ],
     )
    );
  }
  
  void _passwordReset() async {
    String email = _emailController.text;

    try {
      await _auth.passwordReset(email);
      print("Email untuk reset password berhasil dikirim");
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Link for reset password has been sent!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Error occurred: ${e.toString()}',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
