
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_ios/Classes/AppRepository.dart';
import 'package:inventory_ios/Classes/Game.dart';
import 'package:inventory_ios/DashboardScreens/GridItem.dart';
import '../Classes/UserNew.dart';

class DashboardScreen3 extends StatefulWidget {
  final int index;
  const DashboardScreen3({Key? key, required this.index}) : super(key: key);

  @override
  _DashboardScreen3State createState() => _DashboardScreen3State();
}

class _DashboardScreen3State extends State<DashboardScreen3> {
  late Future<UserNew?> userFuture;
  late Future<List<Box>> screen3BoxesFuture;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    initializeScreen3Boxes();
  }

  List<Game> gamesList = [];
  String userID = "";

  fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userID = user.uid;
      print("userid" + userID);
    } else {
      print("user id is null");
    }
    userFuture = fetchUser();
  }

  void initializeScreen3Boxes() {
    screen3BoxesFuture = Future.value([]);
  }

  Future<UserNew?> fetchUser() async {
    final userRepository = UserRepository();
    final UserNew? user = await UserRepository.getUserById(userID);

    if (user == null) {
      print("user is null");
    } else {
      List<Box> boxes = user.getScreen3BoxSetting();
      setState(() {
        screen3BoxesFuture = Future.value(boxes);
      });
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserNew?>(
        future: userFuture, // Assuming fetchUser returns a UserNew object
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.hasError) {
            return Text('Error fetching user: ${userSnapshot.error}');
          } else if (!userSnapshot.hasData || userSnapshot.data == null) {
            return Text('No user data available.');
          } else {
            final user = userSnapshot.data!;
            return FutureBuilder<List<Box>>(
              future: screen3BoxesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available.');
                } else {
                  final screen3Boxes = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: user.gettotalboxesScreen3(),
                    itemBuilder: (context, index) {
                      final List<String> stringList = ['data1'];
                      final Stream<String> stringStream =
                      Stream.fromIterable(stringList);
                      return GridItem(
                          screen3Boxes[index], index + 1, '', stringStream);
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}