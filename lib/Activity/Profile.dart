import 'package:flutter/material.dart';
import 'package:inventory_ios/Classes/Preferences.dart';


void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(), // Handle back navigation
          ),
          title: Text('Profile'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: Text(
                'Account Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                border: Border.all(color: Colors.purple, width: 2), // Outline
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(Icons.access_time_filled, size: 32),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Member Since', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Add fontWeight: FontWeight.bold here
                        const SizedBox(height: 8),
                        FutureBuilder<DateTime?>(
                          future: Preferences.loadDateTimeFromPreferences("created_at"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.toString(), style: const TextStyle(fontSize: 14));
                            } else {
                              return const Text(''); // Or any placeholder text
                            }
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                border: Border.all(color: Colors.blue, width: 2), // Outline
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(Icons.person_pin_rounded, size: 32),
                    const SizedBox(width: 16),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subscribed', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FutureBuilder<bool>(
                          future: Preferences.loadBoolFromPreferences("is_paid_user"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String subscribe = "No";
                              if(snapshot.data == true){
                                subscribe = "Yes";
                              }else{
                                subscribe = "No";
                              }
                              return Text(subscribe, style: const TextStyle(fontSize: 14));
                            } else {
                              return const Text(''); // Or any placeholder text
                            }
                          },
                        ),
                        // Text(Preferences.loadBoolFromPreferences("is_paid_user"), style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                border: Border.all(color: Colors.redAccent, width: 2), // Outline
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(Icons.date_range, size: 32), // Change icon as needed
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Next Subscription Date', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FutureBuilder<String>(
                          future: Preferences.loadStoredValue("subscription_expires"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.toString(), style: const TextStyle(fontSize: 14));
                            } else {
                              return const Text(''); // Or any placeholder text
                            }
                          },
                        ),
                       ],
                    ),
                  ],
                ),
              ),
            ), const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                border: Border.all(color: Colors.lightGreenAccent, width: 2), // Outline
                borderRadius: BorderRadius.circular(10),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Icon(Icons.person, size: 32), // Change icon as needed
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Account Active', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        FutureBuilder<bool>(
                          future: Preferences.loadBoolFromPreferences("login_status"),
                          builder: (context, snapshot) {
                            String active =  "No";
                            if (snapshot.hasData) {
                              if(snapshot.data ==  true){
                                active = "Yes";
                              }else {
                                active = "No";
                              }
                              return Text(active, style: const TextStyle(fontSize: 14));
                            } else {
                              return const Text(''); // Or any placeholder text
                            }
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}