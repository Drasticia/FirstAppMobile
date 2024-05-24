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
        elevation: 5,
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                margin: EdgeInsets.all(15),
                width: 400, // Menambahkan padding
                decoration: BoxDecoration(
                  color: Colors.red[700]?.withOpacity(0.3), // Mengubah warna background container menjadi merah
                  borderRadius: BorderRadius.circular(30), // Mengatur border radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildAppBarButton('Masuk', true),
                    _buildAppBarButton('Daftar', false),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
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
                                  builder: (context) =>  loginScreen()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegScreen()));
                        }
                      },
                      child: Text(isLoginPage ? 'Masyarakat Umum' : 'Masyarakat Umum'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700], // Mengubah warna tombol menjadi merah
                        minimumSize: Size(200, 40),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(isLoginPage ? 'Pemangku Kebijakan' : 'Pemangku Kebijakan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700], // Mengubah warna tombol menjadi merah
                        minimumSize: Size(200, 40),
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
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isLoginPage == isLoginButton ? Colors.white : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isLoginPage == isLoginButton ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}