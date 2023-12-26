
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_ios/Activity/LoginScreen.dart';
import 'package:inventory_ios/Activity/Profile.dart';
import 'package:inventory_ios/Activity/Settings.dart';
import 'package:inventory_ios/Classes/preferences.dart';
import 'package:inventory_ios/DashboardScreens/DashboardScreen1.dart';
import 'package:inventory_ios/DashboardScreens/DashboardScreen2.dart';
import 'package:inventory_ios/DashboardScreens/DashboardScreen3.dart';
import 'package:inventory_ios/DashboardScreens/DashboardScreen4.dart';
import '../Services/AuthService.dart';
// import 'package:wakelock/wakelock.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _tabLength = 1;
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    // Wakelock.enable();
    getAccountType().then((accountType) {
      if (accountType == "A1" || accountType == "E5") {
        _tabLength = 1;
      } else if (accountType == "B2" || accountType == "F6") {
        _tabLength = 2;
      } else if (accountType == "C3") {
        _tabLength = 3;
      } else if (accountType == "D4" || accountType == "G7") {
        _tabLength = 4;
      }
      setState(() {}); // Update state after async operation
    });
  }

  //    A1 - 1 screen lotto
//    B2 - 2 Screen lotto
//    C3 - 3 Screen lotto
//    D4 - 4 screens lotto
//    E5 - 1 lotto 1 Add
//    F6 - 2 lotto 2 Add
//    G7 - 4 lotto - 3 adds


  Future<String> getAccountType() async {
    return Preferences.loadStoredValue("accounttype");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Dashboard'),
          bottom: TabBar(
            tabs: List.generate(
              _tabLength, // Generate tabs dynamically based on length
                  (index) => Tab(text: 'Screen ${index + 1}'),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black, // Background color is black
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/lotterylogo.png',
                      // Replace with your logo image path
                      width: 80.0, // Adjust the width of the logo as needed
                      height: 80.0, // Adjust the height of the logo as needed
                    ),
                    SizedBox(height: 8.0),
                    // Add spacing between the logo and text
                    Text(
                      'Beyond Lottery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.home,
                  size: 30.0,
                  // Increase the icon size to 30.0 (adjust as needed)
                  color: Colors.black,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Handle navigation to the home page here
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   dense: true,
              //   leading: Icon(
              //     Icons.qr_code_scanner,
              //     size: 30.0,
              //     // Increase the icon size to 30.0 (adjust as needed)
              //     color: Colors.black,
              //   ),
              //   title: Text(
              //     'Scan',
              //     style: TextStyle(
              //       fontSize: 18.0,
              //       color: Colors.black,
              //     ),
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Handle navigation to the home page here
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             Barcode(), // Replace with your HomeScreen widget
              //       ),
              //     );
              //   },
              // ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.person,
                  size: 30.0,
                  // Increase the icon size to 30.0 (adjust as needed)
                  color: Colors.black,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Handle navigation to the home page here
                  Navigator.pop(context);
                      // Handle navigation to the home page here
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile(), // Replace with your HomeScreen widget
                        ),
                      );
                },
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.copy,
              //     size: 30.0,
              //     // Increase the icon size to 30.0 (adjust as needed)
              //     color: Colors.black,
              //   ),
              //   title: Text(
              //     'Inventory',
              //     style: TextStyle(
              //       fontSize: 18.0,
              //       color: Colors.black,
              //     ),
              //   ),
              //   onTap: () {
              //     // Handle navigation to the home page here
              //   },
              // ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 30.0,
                  // Increase the icon size to 30.0 (adjust as needed)
                  color: Colors.black,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Settings(
                        screenNames: ['Screen 1', 'Screen 2','Screen 3','Screen 4'],// Replace with your actual screen names
                        onScreenChange: (screenName) {
                          // Handle screen change logic here
                          // ...
                        },
                      ),
                    ),
                  );
                },
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.login,
              //     size: 30.0,
              //     // Increase the icon size to 30.0 (adjust as needed)
              //     color: Colors.black,
              //   ),
              //   title: Text(
              //     'TV Login',
              //     style: TextStyle(
              //       fontSize: 18.0,
              //       color: Colors.black,
              //     ),
              //   ),
              //   onTap: () {
              //     // Handle navigation to the home page here
              //   },
              // ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 30.0,
                  color: Colors.black,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white, // Set background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Add rounded corners
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 30.0,
                            color: Colors.red, // Use a different color
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      content: Text(
                        'Are you sure you want to log out of the application?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            _authService.logoutUser();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(), // Replace with your HomeScreen widget
                              ),
                                  (route) => false, // Clear the navigation stack
                            );
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )

                  );
                },
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(
            _tabLength,
                (index) {
              switch (index) { // Check index and return appropriate screen
                case 0:
                  return DashboardScreen1(index: index + 1);
                case 1:
                  return DashboardScreen2(index: index + 1);
                case 2:
                  return DashboardScreen3(index: index + 1);
                case 3:
                  return DashboardScreen4(index: index + 1);
              // Add additional case statements for more screens
                default:
                  return Text('Invalid Screen');
              }
            },
          ),
        ),
      ),
    );
  }
}







