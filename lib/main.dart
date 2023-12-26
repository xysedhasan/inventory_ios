import 'package:flutter/material.dart';
import 'package:inventory_ios/Activity/Dashboard.dart';
import 'package:inventory_ios/Activity/LoginScreen.dart';
import 'package:inventory_ios/Activity/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'My App',
      navigatorKey: navigatorKey, // Provide a navigator key
      routes: {
        '/home': (context) => Dashboard(),
        '/Login': (context) => LoginScreen(),
        // Add more routes as needed
      },

        theme: ThemeData(
        primaryColor: Color(0xFF2805FF), // Set the primary color to #2805FF
      ),
      home: Splash(
          navigatorKey:
              navigatorKey), // Pass the navigator key to your Splash widget
    );
  }
}
