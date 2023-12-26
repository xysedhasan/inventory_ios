import 'package:flutter/material.dart';
import 'package:inventory_ios/Activity/Dashboard.dart';
import 'package:inventory_ios/Activity/LoginScreen.dart';
import '../Services/AuthService.dart';

class Splash extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  Splash({required this.navigatorKey});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 4), () {
      _checkLoginStatus(context);
    });

    return Scaffold(
      backgroundColor: Color(0xFF2805FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/splashlogo.jpg',
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> _checkLoginStatus(BuildContext context) async {
    final AuthService authService = AuthService(); // Initialize your authentication service
    final isLoggedIn = await authService.isLoggedIn();

     // Use the navigatorKey's context for navigation
    if (isLoggedIn) {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
