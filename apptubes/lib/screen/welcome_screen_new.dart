import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../components/custom_button.dart';

class WelcomeScreenNew extends StatefulWidget {
  const WelcomeScreenNew({Key? key}) : super(key: key);

  @override
  _WelcomeScreenNewState createState() => _WelcomeScreenNewState();
}

class _WelcomeScreenNewState extends State<WelcomeScreenNew> {
  bool isLoginPage = true;
  double statusBarHeight = 0.0;

  @override
  void initState() {
    super.initState();
    getStatusBarHeight();
  }

  Future<void> getStatusBarHeight() async {
    statusBarHeight = await MediaQuery.of(context).viewInsets.top; //height status bar nyesuain hp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        toolbarHeight: statusBarHeight,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10, width: 100),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                margin: EdgeInsets.all(15),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
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
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: isLoginPage ? _buildLoginChoice(context) : _buildRegisterChoice(context),
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
              color: isLoginPage == isLoginButton ? Theme.of(context).primaryColor : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginChoice(BuildContext context) {
    return Padding(
      key: ValueKey(1),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/icons/logo.png', height: 100),
          SizedBox(height: 10),
          Text(
            'Masuk Sebagai',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 80),
          CustomButton(
            text: 'Masyarakat Umum',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          SizedBox(height: 15),
          CustomButton(
            text: 'Pemangku Kebijakan',
            onPressed: () {
              // Navigate to the appropriate login screen for policymakers
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterChoice(BuildContext context) {
    return Padding(
      key: ValueKey(2),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/icons/logo.png', height: 100),
          SizedBox(height: 10),
          Text(
            'Daftar Sebagai',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 80),
          CustomButton(
            text: 'Masyarakat Umum',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
          SizedBox(height: 15),
          CustomButton(
            text: 'Pemangku Kebijakan',
            onPressed: () {
              // Navigate to the appropriate register screen for policymakers
            },
          ),
        ],
      ),
    );
  }
}
