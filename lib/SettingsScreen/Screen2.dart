import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_ios/Classes/preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

class Screen2 extends StatefulWidget {
  final int index;

  const Screen2({Key? key, required this.index}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  // Define variables for radio button values and selection
  int _lotteryTicketsToShow = 18; // Default value
  bool _showCustomBox = false;
  bool _showEmptyBox = true;
  bool _showComingSoonBox = false;
  bool _showImageOptions = false;
  bool _isUploading = false;
  bool _isSaving = false;

  // Image upload variables
  final _imagePicker = ImagePicker();
  XFile? _pickedImage;
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    // Wakelock.enable();
    getTotalBoxesS2().then((totalboxes) {
      setState(() {
        _lotteryTicketsToShow = totalboxes;
      }); // Update state after async operation
    });

    getEmptyboxS2().then((emptybox) {
      setState(() {
        if (emptybox == 'Custom') {
          _showCustomBox = true;
          _showEmptyBox = false;
          _showImageOptions = true;
          _showComingSoonBox = false;
        } else if (emptybox == 'Empty') {
          _showCustomBox = false;
          _showEmptyBox = true;
          _showImageOptions = false;
          _showComingSoonBox = false;
        } else if (emptybox == 'Coming Soon') {
          _showCustomBox = false;
          _showEmptyBox = false;
          _showImageOptions = false;
          _showComingSoonBox = true;
        } else {
          _showCustomBox = false;
          _showEmptyBox = false;
          _showImageOptions = false;
          _showComingSoonBox = false;
        }
      });
    });

    getcustomImage().then((value) {
      _imageUrl = value;
    });
  }

  Future<String> getcustomImage() async {
    return Preferences.loadStoredValue("empty_box_custom_imageS2");
  }

  Future<int> getTotalBoxesS2() async {
    return Preferences.loadStoredIntValue("total_boxesS2");
  }

  Future<String> getEmptyboxS2() {
    return Preferences.loadStoredValue("empty_boxS2");
  }

  // Firebase Storage and Database references
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  // Functions for image upload and link saving
  Future<void> _pickImage() async {
    try {
      final XFile? image =
      await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedImage = image;
        });
        _uploadImage();
      } else {
        // Show a message to the user that no image was picked
      }
    } on PlatformException catch (e) {
      // Handle platform exceptions (e.g., camera not available)
      print("Error:");
      print(e);
    }
  }

  Future<void> _uploadImage() async {
    if (_pickedImage == null) return;

    setState(() {
      _isUploading = true;
    });

    // Success listener
    final uploadTask = _storage
        .ref()
        .child("Custom Images/" +
        DateTime.timestamp().microsecondsSinceEpoch.toString())
        .putFile(File(_pickedImage!.path));
    uploadTask.snapshotEvents.listen((snapshot) async {
      if (snapshot.state == TaskState.success) {
        // Get download URL
        final imageUrl = await snapshot.ref.getDownloadURL();

        String userId = await Preferences.loadStoredValue("id");
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        final DocumentReference documentRef =
        firestore.collection('users').doc(userId);
        await documentRef.update({'screen2.empty_box_custom_image': imageUrl});

        setState(() {
          _imageUrl = imageUrl;
          _isUploading = false;
        });
        // Show success message
        Preferences.saveToPreferences("empty_box_custom_imageS2", imageUrl);
      }
    });

    // Error listener
    uploadTask.catchError((error) {
      setState(() {
        _isUploading = false;
      });
      // Handle upload error and show message to the user
    });
  }

  String getradiolotterybox() {
    if (_showCustomBox) {
      return "Custom";
    } else if (_showEmptyBox) {
      return "Empty";
    } else if (_showComingSoonBox) {
      return "Coming Soon";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lottery ticket options
            Text(
              'Lottery Tickets To Show',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),

            // Radio buttons for lottery ticket count placed vertically
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: 18,
                      groupValue: _lotteryTicketsToShow,
                      onChanged: (value) {
                        setState(() {
                          _lotteryTicketsToShow = value!;
                        });
                      },
                    ),
                    Text('18'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: 32,
                      groupValue: _lotteryTicketsToShow,
                      onChanged: (value) {
                        setState(() {
                          _lotteryTicketsToShow = value!;
                        });
                      },
                    ),
                    Text('32'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: 50,
                      groupValue: _lotteryTicketsToShow,
                      onChanged: (value) {
                        setState(() {
                          _lotteryTicketsToShow = value!;
                        });
                      },
                    ),
                    Text('50'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: 65,
                      groupValue: _lotteryTicketsToShow,
                      onChanged: (value) {
                        setState(() {
                          _lotteryTicketsToShow = value!;
                        });
                      },
                    ),
                    Text('65'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: 80,
                      groupValue: _lotteryTicketsToShow,
                      onChanged: (value) {
                        setState(() {
                          _lotteryTicketsToShow = value!;
                        });
                      },
                    ),
                    Text('80'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<int>(
                      value: 100,
                      groupValue: _lotteryTicketsToShow,
                      onChanged: (value) {
                        setState(() {
                          _lotteryTicketsToShow = value!;
                        });
                      },
                    ),
                    Text('100'),
                  ],
                ),
                // ... add remaining radio buttons similarly
              ],
            ),

            // Text and radio buttons for empty/coming soon/custom box
            SizedBox(height: 20.0),
            Text(
              'What to show in box when lottery ticket is not selected?',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            // Radio buttons for box content placed vertically
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _showEmptyBox,
                      onChanged: (value) {
                        setState(() {
                          _showEmptyBox = value!;
                          _showComingSoonBox = !value!;
                          _showCustomBox = false;
                          _showImageOptions = false;
                        });
                      },
                    ),
                    Text('Empty'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _showComingSoonBox,
                      onChanged: (value) {
                        setState(() {
                          _showComingSoonBox = value!;
                          _showEmptyBox = !value!;
                          _showCustomBox = false;
                          _showImageOptions =  false;
                        });
                      },
                    ),
                    Text('Coming Soon'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _showCustomBox,
                      onChanged: (value) {
                        setState(() {
                          _showCustomBox = value!;
                          _showEmptyBox = false;
                          _showComingSoonBox = false;
                          _showImageOptions = true;
                        });
                      },
                    ),
                    Text('Custom'),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.0),
            Visibility(
              visible: _showImageOptions,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Upload Custom Button'),
                  ),
                  Visibility(
                    visible: _isUploading,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Image view
                  Visibility(
                    visible: _imageUrl.isNotEmpty,
                    child: Image.network(
                      _imageUrl,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Save settings button
            SizedBox(height: 20.0),
            _isSaving
                ? CircularProgressIndicator()
                : GestureDetector(
              onTap: _saveSettings,
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                      "Save Settings",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveSettings() async {
    setState(() {
      _isSaving = true;
    });
    getradiolotterybox();
    String userId = await Preferences.loadStoredValue("id");
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference documentRef =
    firestore.collection('users').doc(userId);
    await documentRef.update({'screen2.empty_box': getradiolotterybox()});
    await documentRef.update({'screen2.total_boxes': _lotteryTicketsToShow});

    setState(() {
      _isSaving = false;
    });
  }
}
