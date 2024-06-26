import 'package:apptubes/models/api/firebase_messaging.dart';
import 'package:apptubes/screen/login_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/custom_dropdown.dart';
import '../models/api/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double statusBarHeight = 0.0;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();
  bool _obscurePassword = true;

  String? selectedRegion;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _postalCodeController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/icons/logo.png', height: 100), // Adjust the asset path accordingly.
                    SizedBox(height: 20),
                    Text(
                      'Daftar Sebagai\nMasyarakat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'Nama',
                      hintText: 'Masukkan nama lengkap',
                      controller: _nameController,
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
                      obscureText: _obscurePassword,
                      showSuffixIcon: true,
                      onSuffixIconTap: _togglePasswordVisibility,
                    ),
                    CustomDropdown(
                      hintText: 'Pilih daerah tempat kamu tinggal',
                      items: ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Medan'],
                      value: selectedRegion,
                      onChanged: (String? origincity) {
                        setState(() {
                          selectedRegion = origincity;
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
          ),
          Column(
            children: [
              Text(
                'bLeh.co 2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
              Text(
                'Developed With Our Heart',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future _signUp() async {
    String username = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    //create user
    User? user = await _auth.signUp(email, password);

    if (user != null){
      print("Akun telah berhasil dibuat");

      addUserDetails(
          _nameController.text.trim(),
          _emailController.text.trim(),
          selectedRegion,
          _postalCodeController.text.trim()
      );

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

  Future addUserDetails(String name, String email, String? origincity, String postalcode) async {

    await FirebaseFirestore.instance.collection('user').add({
      'name': name,
      'email': email,
      'origin city': origincity,
      'postal code': postalcode,
    });
  }

}
