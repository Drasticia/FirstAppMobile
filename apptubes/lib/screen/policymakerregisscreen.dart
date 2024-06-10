import 'package:apptubes/screen/policymarkerloginscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/custom_dropdown.dart';

class PolicyMakerRegisterScreen extends StatefulWidget {
  @override
  _PolicyMakerRegisterScreenState createState() => _PolicyMakerRegisterScreenState();
}

class _PolicyMakerRegisterScreenState extends State<PolicyMakerRegisterScreen> {
  double statusBarHeight = 0.0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  String? selectedRegion;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _organizationController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getStatusBarHeight();
  }
  Future<void> getStatusBarHeight() async {
    // statusBarHeight = await MediaQuery.of(context).viewInsets.top; //height status bar nyesuain hp
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/icons/logo.png', height: 100), // Adjust the asset path accordingly.
              SizedBox(height: 20),
              Text(
                'Daftar Sebagai\nPemangku Kebijakan',
                textAlign: TextAlign.center,
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
                obscureText: true,
              ),
              CustomTextField(
                labelText: 'Organisasi',
                hintText: 'Masukkan nama organisasi',
                controller: _organizationController,
              ),
              CustomDropdown(
                hintText: 'Pilih daerah tempat kamu bekerja',
                items: ['Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta', 'Medan'],
                value: selectedRegion,
                onChanged: (String? origincity) {
                  setState(() {
                    selectedRegion = origincity;
                  });
                },
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

  Future _signUp() async {
    String username = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String organization = _organizationController.text;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        print("Akun telah berhasil dibuat");

        addUserDetails(
            _nameController.text.trim(),
            _emailController.text.trim(),
            selectedRegion,
            _organizationController.text.trim()
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

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PolicyMakerLoginScreen()));
      }
    } catch (e) {
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
  
  Future addUserDetails(String name, String email, String? origincity, String organization) async {
    await FirebaseFirestore.instance.collection('policy_makers').add({
      'name': name,
      'email': email,
      'origin city': origincity,
      'organization': organization,
    });
  }
}
