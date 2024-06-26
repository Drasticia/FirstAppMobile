import 'package:apptubes/components/bottomnavbar(another).dart';
import 'package:apptubes/screen/policymakerregisscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import 'forgot_password.dart';

class PolicyMakerLoginScreen extends StatefulWidget {
  @override
  _PolicyMakerLoginScreenState createState() => _PolicyMakerLoginScreenState();
}

class _PolicyMakerLoginScreenState extends State<PolicyMakerLoginScreen> with SingleTickerProviderStateMixin {
  double statusBarHeight = 0.0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    // getStatusBarHeight();
  }

  // Future<void> getStatusBarHeight() async {
  //   statusBarHeight = await MediaQuery.of(context).viewInsets.top; //height status bar nyesuain hp
  // }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        toolbarHeight: statusBarHeight,
        automaticallyImplyLeading: false,
      ),
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
                'Masuk Sebagai\nPemangku Kebijakan',
                textAlign: TextAlign.center,
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
                controller: _emailController,
              ),
              CustomTextField(
                labelText: 'Password',
                hintText: 'Masukkan password',
                controller: _passwordController,
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    'Lupa password?',
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Masuk',
                onPressed: _signIn,
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
                            MaterialPageRoute(builder: (context) => PolicyMakerRegisterScreen()),
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

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        print("Akun berhasil diverifikasi");
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success!',
            message:
            'Account has been authorized!',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavbarAnother()));
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message:
          'Wrong email or password!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
