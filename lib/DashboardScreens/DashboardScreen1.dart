
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_ios/Classes/AppRepository.dart';
import 'package:inventory_ios/Classes/Game.dart';
import 'package:inventory_ios/Classes/preferences.dart';
import 'package:inventory_ios/DashboardScreens/GridItem.dart';
import '../Classes/UserNew.dart';
import 'package:logger/logger.dart';

class DashboardScreen1 extends StatefulWidget {
  final int index;
  const DashboardScreen1({Key? key, required this.index}) : super(key: key);

  @override
  _DashboardScreen1State createState() => _DashboardScreen1State();
}

class _DashboardScreen1State extends State<DashboardScreen1> {
  late Future<UserNew?> userFuture;
  late Future<List<Box>> screen1BoxesFuture;

  @override
  void initState() {
    super.initState();
    fetchGames();
    fetchUserInfo();
    initializeScreen1Boxes();
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

  void initializeScreen1Boxes() {
    screen1BoxesFuture = Future.value([]);
  }

  Future<UserNew?> fetchUser() async {
    final userRepository = UserRepository();
    final UserNew? user = await UserRepository.getUserById(userID);

    if (user == null) {
      print("user is null");
    } else {
      List<Box> boxes = user.getScreen1BoxSetting();
      print("screen1size" + boxes.length.toString());
      setState(() {
        screen1BoxesFuture = Future.value(boxes);
      });

      Preferences.saveToPreferences("accounttype", user.getAccountType());
      Preferences.saveToPreferences("region", user.getRegion());

      Preferences.saveDateTimeToPreferences("created_at", user.getCreatedAt());
      Preferences.saveBoolToPreferences("is_paid_user", user.ispaidUser());
      Preferences.saveToPreferences("subscription_expires", user.subscriptonExpires());
      Preferences.saveBoolToPreferences("login_status", user.loginstatus());


      if(user.getAccountType() == "A1"){
        Preferences.saveToPreferences("empty_box_custom_imageS1", user.getcustomimageScreen1());
        Preferences.saveIntToPreferences("total_boxesS1", user.gettotalboxesScreen1());
        Preferences.saveToPreferences("empty_boxS1", user.getEmptyBoxS1());
      }else if(user.getAccountType() == "B2"){
        Preferences.saveIntToPreferences("total_boxesS1", user.gettotalboxesScreen1());
        Preferences.saveIntToPreferences("total_boxesS2", user.gettotalboxesScreen2());
        Preferences.saveToPreferences("empty_box_custom_imageS1", user.getcustomimageScreen1());
        Preferences.saveToPreferences("empty_box_custom_imageS2", user.getcustomimageScreen2());
        Preferences.saveToPreferences("empty_boxS1", user.getEmptyBoxS1());
        Preferences.saveToPreferences("empty_boxS2", user.getEmptyBoxS2());
      }else if(user.getAccountType() == "C3"){
        Preferences.saveIntToPreferences("total_boxesS1", user.gettotalboxesScreen1());
        Preferences.saveIntToPreferences("total_boxesS2", user.gettotalboxesScreen2());
        Preferences.saveIntToPreferences("total_boxesS3", user.gettotalboxesScreen3());
        Preferences.saveToPreferences("empty_box_custom_imageS1", user.getcustomimageScreen1());
        Preferences.saveToPreferences("empty_box_custom_imageS2", user.getcustomimageScreen2());
        Preferences.saveToPreferences("empty_box_custom_imageS3", user.getcustomimageScreen3());
        Preferences.saveToPreferences("empty_boxS1", user.getEmptyBoxS1());
        Preferences.saveToPreferences("empty_boxS2", user.getEmptyBoxS2());
        Preferences.saveToPreferences("empty_boxS3", user.getEmptyBoxS3());
      }else if(user.getAccountType() == "D4"){
        Preferences.saveIntToPreferences("total_boxesS1", user.gettotalboxesScreen1());
        Preferences.saveIntToPreferences("total_boxesS2", user.gettotalboxesScreen2());
        Preferences.saveIntToPreferences("total_boxesS3", user.gettotalboxesScreen3());
        Preferences.saveIntToPreferences("total_boxesS4", user.gettotalboxesScreen4());
        Preferences.saveToPreferences("empty_box_custom_imageS1", user.getcustomimageScreen1());
        Preferences.saveToPreferences("empty_box_custom_imageS2", user.getcustomimageScreen2());
        Preferences.saveToPreferences("empty_box_custom_imageS3", user.getcustomimageScreen3());
        Preferences.saveToPreferences("empty_box_custom_imageS4", user.getcustomimageScreen4());
        Preferences.saveToPreferences("empty_boxS1", user.getEmptyBoxS1());
        Preferences.saveToPreferences("empty_boxS2", user.getEmptyBoxS2());
        Preferences.saveToPreferences("empty_boxS3", user.getEmptyBoxS3());
        Preferences.saveToPreferences("empty_boxS4", user.getEmptyBoxS4());
      }
    }
    return user;
  }

  fetchGames() async {
    final gameRepository = GameRepository();
    final games = await gameRepository.queryGamesInTexas();

    if (games == null) {
      print('Unable to retrieve Games');
    } else {
      gamesList = games;
      Preferences.saveGamesToSharedPreferences(gamesList);
      Preferences.loadGamesFromSharedPreferences();

      var logger = Logger();
      logger.d('This is a log message6.');
    }
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
              future: screen1BoxesFuture,
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
                  final screen1Boxes = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: user.gettotalboxesScreen1(),
                    itemBuilder: (context, index) {
                      final List<String> stringList = ['data1'];
                      final Stream<String> stringStream =
                      Stream.fromIterable(stringList);
                      return GridItem(
                          screen1Boxes[index], index + 1, '', stringStream);
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