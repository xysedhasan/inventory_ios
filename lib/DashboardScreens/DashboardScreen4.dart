
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_ios/Classes/AppRepository.dart';
import 'package:inventory_ios/Classes/Game.dart';
import 'package:inventory_ios/DashboardScreens/GridItem.dart';
import '../Classes/UserNew.dart';

class DashboardScreen4 extends StatefulWidget {
  final int index;
  const DashboardScreen4({Key? key, required this.index}) : super(key: key);

  @override
  _DashboardScreen4State createState() => _DashboardScreen4State();
}

class _DashboardScreen4State extends State<DashboardScreen4> {
  late Future<UserNew?> userFuture;
  late Future<List<Box>> screen4BoxesFuture;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    initializeScreen4Boxes();
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

  void initializeScreen4Boxes() {
    screen4BoxesFuture = Future.value([]);
  }

  Future<UserNew?> fetchUser() async {
    final userRepository = UserRepository();
    final UserNew? user = await UserRepository.getUserById(userID);

    if (user == null) {
      print("user is null");
    } else {
      List<Box> boxes = user.getScreen4BoxSetting();
      setState(() {
        screen4BoxesFuture = Future.value(boxes);
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
              future: screen4BoxesFuture,
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
                  final screen4Boxes = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: user.gettotalboxesScreen4(),
                    itemBuilder: (context, index) {
                      final List<String> stringList = ['data1'];
                      final Stream<String> stringStream =
                      Stream.fromIterable(stringList);
                      return GridItem(
                          screen4Boxes[index], index + 1, '', stringStream);
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