import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_ios/Classes/AppRepository.dart';
import 'package:inventory_ios/Classes/Game.dart';
import 'package:inventory_ios/Classes/Preferences.dart';
import 'package:inventory_ios/Classes/UserNew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTicket extends StatefulWidget {
  Box box;
  bool isAnimation = false;
  int indexnum;
  UpdateTicket({required this.box, required this.indexnum});

  @override
  _UpdateTicketState createState() => _UpdateTicketState();
}

class _UpdateTicketState extends State<UpdateTicket> {
  TextEditingController lotteryNumberController = TextEditingController();
  TextEditingController currentTicketNumberController = TextEditingController();

  String? enteredLotteryNumber;
  String? enteredCurrentTicketNumber;
  late String boximage;
  bool? isAnimation;
  String? completeTicketNumber = '';
  String imageurl = "";
  String _currentImage = '';
  bool showProgress = false;
  late int index;
  bool _shouldShowCurrentTicketText = false;

  @override
  void initState() {
    super.initState();

    // Set initial values to controllers
    lotteryNumberController.text = widget.box.game_no ?? '';
    currentTicketNumberController.text = widget.box.ticket_no ?? '';
    isAnimation = widget.box.animation;
    boximage = widget.box.game_image;
    index = widget.indexnum;

    _currentImage = boximage;
    // Attach the listener to onChanged event
    lotteryNumberController.addListener(() {
      // Check if the entered text has reached 14 characters
      if (lotteryNumberController.text.length == 14) {
        completeTicketNumber =
            (int.parse(lotteryNumberController.text) - 1).toString();
        // Save the text to a variable
        if (lotteryNumberController.text.length >= 3) {
          String gamenumber =
              lotteryNumberController.text.toString().substring(0, 4);
          lotteryNumberController.text = gamenumber;
        }
        lotteryNumberController.clear();
          updateClicked(
              lotteryNumberController,
              currentTicketNumberController,
              widget.indexnum,
              completeTicketNumber!,
              isAnimation!,
              _currentImage);

      } else {
        completeTicketNumber = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the box object to display data in the new screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Lottery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Lottery Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white, // You can customize the background color
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: _currentImage == null || _currentImage.isEmpty
                  ? Image.asset('assets/image/emptyimage.png')
                  : Image.network(
                _currentImage,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: isAnimation ?? false,
                  onChanged: (value) {
                    // Handle checkbox state change
                    setState(() {
                      isAnimation = value; // Update state variable
                    });
                  },
                ),
                Text('Animate'),
              ],
            ),
            SizedBox(height: 8.0),
            Text('Clear Text Before Scanning',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16.0),
            Text('Lottery Number', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: lotteryNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Lottery Number',
              ),
              maxLength: 14,
            ),


            SizedBox(height: 16.0),
            Visibility(
              visible: _shouldShowCurrentTicketText, // Define your state variable
              child: Text('Current Ticket Number', style: TextStyle(fontSize: 16)),
            ),
            Visibility(
              visible: _shouldShowCurrentTicketText, // Define your state variable
              child: TextFormField(
                controller: currentTicketNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Current Ticket Number',
                ),
                maxLength: 14,
              ),
            ),

            SizedBox(height: 32.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showProgress = true; // Show progress bar
                    });
                   String img =  await updateClicked(
                        lotteryNumberController,
                        currentTicketNumberController,
                        widget.indexnum,
                        completeTicketNumber!,
                        isAnimation!,
                        _currentImage);
                    setState(() {
                      showProgress = false; // Hide progress bar
                      _currentImage =img;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: showProgress
                      ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                      : Text('Update'),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      showProgress = true; // Show progress bar
                    });
                    Box boxdata = new Box(
                        game_image: "",
                        game_no: "",
                        ticket_no: "",
                        ticket_value: "",
                        pack_size: "",
                        animation: false);
                    await updateBoxSettingAtIndex(index,boxdata,true,lotteryNumberController, currentTicketNumberController);
                    setState(() {
                      showProgress = false; // Hide progress bar
                      _currentImage ="";
                    });
                  },


                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Clear Text',
                style: TextStyle(fontSize: 16, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}


bool containsOnlyDigits(String value) {
  // Regular expression to match only digits
  final RegExp regex = RegExp(r'^[0-9]+$');
  // Test if the string contains only digits
  return regex.hasMatch(value);
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<String> updateClicked(
    TextEditingController lotteryNumberController,
    TextEditingController ticketNumberController,
    int index,
    String completeTicketNumber,
    bool animateRadiobtn,
    String _currentImage) async {
  String gameNumber = lotteryNumberController.text;
  if (gameNumber.length == 14) {
    gameNumber = gameNumber.substring(0, 4);
  }
  // progressBar.setVisibility(View.VISIBLE);
  String gameimageurl = "", ticketValue = "", patcksize = "";
  bool isGameexist = false;

  final gameRepository = GameRepository();
  final games = await gameRepository.queryGamesInTexas();

  if (games == null) {
    print('Unable to retrieve Games');
    showToast('Unable to retrieve Games');
  } else {
    // List<Game> games = await Preferences.loadGamesFromSharedPreferences()   ;
    if (games != null || games.length == 0) {
      for (var game in games) {
        if (game.number == gameNumber) {
          _currentImage = game.imageUrl;
          isGameexist = true;
          gameimageurl = game.imageUrl;
          ticketValue = game.ticketValue;
          patcksize = game.packSize;
          break;
        }
      }
    }
  }

  if (isGameexist) {
    Box boxdata = new Box(
        game_image: gameimageurl,
        game_no: gameNumber,
        ticket_no: completeTicketNumber,
        ticket_value: ticketValue,
        pack_size: patcksize,
        animation: animateRadiobtn);
      await updateBoxSettingAtIndex(
        index, boxdata, false, lotteryNumberController, ticketNumberController);
  } else {
    showToast("Game Number not exist!");
    // progressBar.setVisibility(View.GONE);
  }
  return _currentImage;
}

Future<bool> updateBoxSettingAtIndex(
    int index,
    Box updatedBox,
    bool isdelete,
    TextEditingController lotterynumber,
    TextEditingController ticketnumber) async {
  String userId = await Preferences.loadStoredValue("id");
  UserNew? user = await UserRepository.getUserById(userId);
  List<Box> boxSettings = user!.screen1.boxSettings;

  // Convert Box objects to JSON
  List<Map<String, dynamic>> boxSettingsJson = [];
  for (Box box in boxSettings) {
    Map<String, dynamic> boxJson = {};
    boxJson['game_image'] = box.game_image;
    boxJson['game_no'] = box.game_no;
    boxJson['ticket_no'] = box.ticket_no;
    boxJson['ticket_value'] = box.ticket_value;
    boxJson['pack_size'] = box.pack_size;
    boxJson['animation'] = box.animation;
    boxSettingsJson.add(boxJson);
  }

  if (index >= 0 && index < boxSettings.length) {
    boxSettingsJson[index - 1] =
        updatedBox.toJson(); // Use toJson method if you have JSON serialization

    // boxSettings[index] = updatedBox;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference documentRef =
        firestore.collection('users').doc(userId);

    // for(int i=0;i<boxSettings.length;i++){
    //   print(boxSettings[i]);
    // }

    // if (screenNo == '1') {
try{
    await documentRef.update({'screen1.box_settings': boxSettingsJson});

    // Update UI after successful update
    // progressBar.hide();
    // Picasso.get().load(updatedBox.gameImage).into(gameImage);

    if (isdelete) {
      lotterynumber.text = '';
      ticketnumber.text = '';
      // Toast.makeText(context, 'Delete Successful', Toast.LENGTH_SHORT).show();
      showToast("Delete Successfully");
    } else {
      // Toast.makeText(context, 'Update Successful', Toast.LENGTH_SHORT).show();
      showToast('Update Successful');
    }


    } catch (e) {
      // Handle error
      print('Error updating box setting: $e');
      // progressBar.hide();
      showToast("Something went wrong!");
    }
  }

  return false;
}
// }

void updateData(
    String userId, String screenNo, Map<String, dynamic> boxSettings) async {
  try {} catch (e) {
    print("Error updating data: $e");
  }
}
