import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/custom_dropdown.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TapGestureRecognizer _tapRecognizer = TapGestureRecognizer();

  String? selectedRegion;

  void _register() {
    // Handle register logic here
    print('Name: ${nameController.text}, Email: ${emailController.text}, Password: ${passwordController.text}, Region: $selectedRegion, Postal Code: ${postalCodeController.text}');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    postalCodeController.dispose();
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
                controller: nameController,
              ),
              CustomTextField(
                labelText: 'Email',
                hintText: 'Masukkan email',
                controller: emailController,
              ),
              CustomTextField(
                labelText: 'Password',
                hintText: '8 Karakter dan kombinasi simbol',
                controller: passwordController,
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
                controller: postalCodeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Daftar',
                onPressed: _register,
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
}
