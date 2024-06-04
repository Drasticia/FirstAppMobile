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
        // assgin warna, cara panggil ===> color: Theme.of(context).blablabla,
        primarySwatch: createMaterialColor(Color(0xFFF6D62E)),
        primaryColor: Color(0xFFF6D62E),
        hintColor: Color(0xFF2E96F6),
        cardColor: Color(0xFFF62E2E),
        /*  |=================================================================================================|
            | assign text, cara panggil ===> style: Theme.of(context).textTheme.blablabla,                    |
            |=================================================================================================|
            | kalo style yang dipengen ga ada, panggil manual fontnya                                         |
            | style: TextStyle(                                                                               |
            |   fontFamily: 'SFProText',                                                                      |
            |   fontWeight: FontWeight.w900, ===> w100=ultrathin sd w900=black, liat di pubspec               |
            |   fontStyle: FontStyle.italic, ===> kalo pengen italic                                          |
            |   fontSize: 24,                                                                                 |
            | ),                                                                                              |
            |=================================================================================================|
            | Gabungin theme color n text                                                                     |
            | style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Theme.of(context).primaryColor)|
            |=================================================================================================|

             MENDING PAKE THEME TEXT ATO ASSIGN MANUAL AJA? THEME = KONSISTEN TAPI GA SEMUA KAYAK YANG DIPENGEN
             TRUZ MINX GX BISA CUSTOM NAMA THEME, SEMUA CLASS BAWAAN AMCRIT BAT NI FLUTTER

             SELECT ONE, NOT MULTIPLE CHOICE OR BEBAS:
             A. KALO MAU PAKE THEME N THEN SESUAI SAMA YANG DIPENGEN, CUSTOM LAGI AJA WEIGHT, SIZE N LAINNYA YHHH
             B. KALO MAU ASSIGN MANUAL, BAGIAN TEXT THMENYA DILET AZA OKRAY DON

             JAWAB DI GRUP AOKWOAKWAOKWAOK NI CERITANYA EASTER EGG, JADI SO WELL
        */
        fontFamily: 'SFProText',
        // textTheme: const TextTheme(
        //   displayLarge: TextStyle(fontFamily: 'SFProText', fontSize: 96, fontWeight: FontWeight.w900, letterSpacing: -1.5),  // Black
        //   displayMedium: TextStyle(fontFamily: 'SFProText', fontSize: 60, fontWeight: FontWeight.w800, letterSpacing: -0.5),  // Heavy
        //   displaySmall: TextStyle(fontFamily: 'SFProText', fontSize: 48, fontWeight: FontWeight.w700),  // Bold
        //   headlineMedium: TextStyle(fontFamily: 'SFProText', fontSize: 34, fontWeight: FontWeight.w600, letterSpacing: 0.25),  // Semibold
        //   headlineSmall: TextStyle(fontFamily: 'SFProText', fontSize: 24, fontWeight: FontWeight.w500),  // Medium
        //   titleLarge: TextStyle(fontFamily: 'SFProText', fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),  // Medium
        //   titleMedium: TextStyle(fontFamily: 'SFProText', fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),  // Regular
        //   titleSmall: TextStyle(fontFamily: 'SFProText', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),  // Medium
        //   bodyLarge: TextStyle(fontFamily: 'SFProText', fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),  // Regular
        //   bodyMedium: TextStyle(fontFamily: 'SFProText', fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),  // Regular
        //   bodySmall: TextStyle(fontFamily: 'SFProText', fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),  // Regular
        //   labelLarge: TextStyle(fontFamily: 'SFProText', fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.25),  // Bold
        //   labelSmall: TextStyle(fontFamily: 'SFProText', fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),  // Regular
        // ),
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
