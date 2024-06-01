//
// // import 'package:apptubes/screen/welcome_screen.dart';
// // import 'package:flutter/material.dart';
//
// // void main(){
// //   runApp(const MyApp());
// // }
//
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       title: 'Fire and Disaster Management',
// //       theme: ThemeData(
// //         primarySwatch: Color.fromARGB(255, 236, 216, 37),
// //       ),
// //       // debugShowCheckedModeBanner: false,
// //       home: WelcomeScreen()
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:apptubes/screen/welcome_screen.dart';
//
// // void main(){
// //   runApp(const MyApp());
// // }
//
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Fire and Disaster Management',
// //       theme: ThemeData(
// //         primarySwatch: createMaterialColor(Color(0xFFF6D62E)),
// //         primaryColor: Color(0xFFF6D62E), // Primary color
// //         hintColor: Color(0xFF2E96F6),  // Accent color
// //         cardColor: Color(0xFFF62E2E),   // Error color
// //       ),
// //       home: WelcomeScreen(),
// //     );
// //   }
//
// //   MaterialColor createMaterialColor(Color color) {
// //     List strengths = <double>[.05];
// //     final Map<int, Color> swatch = {};
// //     final int r = color.red, g = color.green, b = color.blue;
//
// //     for (int i = 1; i < 10; i++) {
// //       strengths.add(0.1 * i);
// //     }
// //     strengths.forEach((strength) {
// //       final double ds = 0.5 - strength;
// //       swatch[(strength * 1000).round()] = Color.fromRGBO(
// //         r + ((ds < 0 ? r : (255 - r)) * ds).round(),
// //         g + ((ds < 0 ? g : (255 - g)) * ds).round(),
// //         b + ((ds < 0 ? b : (255 - b)) * ds).round(),
// //         1,
// //       );
// //     });
// //     return MaterialColor(color.value, swatch);
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'screen/login_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fire and Disaster Management',
//       theme: ThemeData(
//         primarySwatch: createMaterialColor(Color(0xFFF6D62E)),
//         primaryColor: Color(0xFFF6D62E),
//         hintColor: Color(0xFF2E96F6),
//         cardColor: Color(0xFFF62E2E),
//       ),
//       home: LoginScreen(),
//     );
//   }
//
//   MaterialColor createMaterialColor(Color color) {
//     List strengths = <double>[.05];
//     final Map<int, Color> swatch = {};
//     final int r = color.red, g = color.green, b = color.blue;
//
//     for (int i = 1; i < 10; i++) {
//       strengths.add(0.1 * i);
//     }
//     strengths.forEach((strength) {
//       final double ds = 0.5 - strength;
//       swatch[(strength * 1000).round()] = Color.fromRGBO(
//         r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//         g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//         b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//         1,
//       );
//     });
//     return MaterialColor(color.value, swatch);
//   }
// }

import 'package:apptubes/screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/welcome_screen_new.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire and Disaster Management',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFFF6D62E)),
        primaryColor: Color(0xFFF6D62E),
        hintColor: Color(0xFF2E96F6),
        cardColor: Color(0xFFF62E2E),
      ),
      home: SplashScreen(),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
