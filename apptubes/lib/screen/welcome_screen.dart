import 'package:apptubes/screen/login_screen.dart';
import 'package:apptubes/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:apptubes/screen/regScreen.dart';
import 'package:apptubes/screen/loginscreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoginPage = true; // Toggle this to switch between pages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700], // Mengubah warna AppBar menjadi merah
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 192, 65, 0.612),
                  Color.fromRGBO(249, 61, 61, 0.612)
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10, width: 100), // Jarak dari AppBar
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                margin: EdgeInsets.all(15),
                width: 400, // Menambahkan padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Mengatur border radius
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromRGBO(255, 22, 22, 1),
                      Color.fromRGBO(255, 125, 125, 1)
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildAppBarButton('Lebet', true),
                    _buildAppBarButton('Daftar', false),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset('lib/icons/Group 6.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        isLoginPage ? 'Masuk Sebagai' : 'Daftar Sebagai',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (isLoginPage) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  LoginScreen()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  RegisterScreen()));
                          }
                        },
                        child: Text(
                          isLoginPage ? 'Masyarakat Umum' : 'Masyarakat Umum',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 22, 22, 1), // Mengubah warna tombol menjadi merah
                          minimumSize: Size(300, 50),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          isLoginPage ? 'Pemangku Kebijakan' : 'Pemangku Kebijakan',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 22, 22, 1), // Mengubah warna tombol menjadi merah
                          minimumSize: Size(300, 50),
                        ),
                      ),
                    ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarButton(String title, bool isLoginButton) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLoginPage = isLoginButton;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isLoginPage == isLoginButton ? Colors.white : Colors.transparent,
          
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isLoginPage == isLoginButton ? Colors.red : const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}