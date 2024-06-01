import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../components/custom_button.dart';

class WelcomeScreenNew extends StatefulWidget {
  @override
  _WelcomeScreenNewState createState() => _WelcomeScreenNewState();
}

class _WelcomeScreenNewState extends State<WelcomeScreenNew> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _pageController.hasClients && _pageController.page == 0
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: _pageController.hasClients && _pageController.page == 0
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _pageController.animateToPage(1,
                      duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _pageController.hasClients && _pageController.page == 1
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: _pageController.hasClients && _pageController.page == 1
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildLoginChoice(context),
                _buildRegisterChoice(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginChoice(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/logo.png', height: 100),
        SizedBox(height: 20),
        Text(
          'Login Sebagai',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 20),
        CustomButton(
          text: 'Pemangku Kebijakan',
          onPressed: () {
            // Navigate to the appropriate login screen for policymakers
          },
        ),
        CustomButton(
          text: 'Masyarakat Umum',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRegisterChoice(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('lib/icons/logo.png', height: 100),
        SizedBox(height: 20),
        Text(
          'Daftar Sebagai',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 20),
        CustomButton(
          text: 'Pemangku Kebijakan',
          onPressed: () {
            // Navigate to the appropriate register screen for policymakers
          },
        ),
        CustomButton(
          text: 'Masyarakat Umum',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
        ),
      ],
    );
  }
}
