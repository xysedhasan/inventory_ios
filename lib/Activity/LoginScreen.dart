import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_ios/Activity/Dashboard.dart';
import 'package:inventory_ios/Classes/Preferences.dart';
import '../Services/AuthService.dart';
import '../Services/firebase_auth.dart';
import '../Widgets/FormContainerWidget.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigning = false;
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }


  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      // User is logged in, navigate to dashboard
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()), // Replace with your Dashboard widget
            (route) => false, // Clear the navigation stack
      );
    } else {
      // User is not logged in, stay on the login screen
      setState(() {
        _isLoggedIn = loggedIn;
      });
    }
  }

  Future<bool> _onWillPop() async {
    // Check if the current route is the login screen
    if (Navigator.of(context).canPop() &&
        ModalRoute.of(context)!.settings.name == "/login") {
      // Close the app if on login screen
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return false; // Prevent default back navigation
    } else {
      // Allow back navigation for other routes
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: WillPopScope(
        onWillPop: _onWillPop, // This function will handle back button press
        child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/lotterylogo.png',
                width: 120.0,
                height: 120.0,
              ),
              SizedBox(height: 16.0),
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              _isSigning
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: _signIn,
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
            ],
          ),
        ),
      ),
    ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning =
          true; // Set the signing flag to true when the button is clicked
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      String userId = user.uid;
      Preferences.saveToPreferences("id", userId);
      // Instead, you can use your _authService to log in
      await _authService.loginUser();
    }

    setState(() {
      _isSigning =
          false; // Set the signing flag to true when the button is clicked
    });


    if (user != null) {
      print("User is successfully signedIn");
      Navigator.of(context).pushNamed("/home");
    } else {
      print("Some error happened");
      // Show a toast message for the error
      Fluttertoast.showToast(
        msg: "Login failed. Please check your credentials.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
