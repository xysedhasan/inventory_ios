import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Box {

  final String game_image;
  final String game_no;
  final String ticket_no;
  final String ticket_value;
  final String pack_size;
  final bool animation;

  Box({
    required this.game_image,
    required this.game_no,
    required this.ticket_no,
    required this.ticket_value,
    required this.pack_size,
    required this.animation,
  });

  Map<String, dynamic> toJson() {
    return {
      'game_image': game_image,
      'game_no': game_no,
      'ticket_no':ticket_no,
      'ticket_value':ticket_value,
      'pack_size':pack_size,
      'animation':animation,
    };
  }


}

class Screen1 {
  final List<Box> boxSettings;
  final String emptyBox;
  final String emptyBoxCustomImage;
  final String orientation;
  final bool showHeader;
  final int totalBoxes;

  Screen1({
    required this.boxSettings,
    required this.emptyBox,
    required this.emptyBoxCustomImage,
    required this.orientation,
    required this.showHeader,
    required this.totalBoxes,
  });
}

class Screen3 {
  final String mediaType;
  final String mediaUrl;
  final String orientation;

  Screen3({
    required this.mediaType,
    required this.mediaUrl,
    required this.orientation,
  });
}

class UserNew {
  final String id;
  final String accountType;
  final String address;
  final String device;
  final String email;
  final String lastLogin;
  final String name;
  final String phone;
  final String role;
  final String subscriptionDate;
  final String region;
  final String companyName;
  final String contactPersonLocation;
  final String contactPersonPhone;
  final String locationPhone;
  final String ownerPhone;
  final String storeAddress;
  final String storeEmail;
  final String storeName;
  final String subscriptionExpires;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isBlocked;
  final bool isPaidUser;
  final bool loginStatus;
  final bool subscribeInventory;
  final Screen1 screen1;
  final Screen1 screen2;
  final Screen1 screen3;
  final Screen1 screen4;
  final Screen3 screen5;
  final Screen3 screen6;
  final Screen3 screen7;




  UserNew({
    required this.id,
    required this.accountType,
    required this.address,
    required this.device,
    required this.email,
    required this.lastLogin,
    required this.name,
    required this.phone,
    required this.role,
    required this.subscriptionDate,
    required this.region,
    required this.companyName,
    required this.contactPersonLocation,
    required this.contactPersonPhone,
    required this.locationPhone,
    required this.ownerPhone,
    required this.storeAddress,
    required this.storeEmail,
    required this.storeName,
    required this.subscriptionExpires,
    required this.createdAt,
    required this.updatedAt,
    required this.isBlocked,
    required this.isPaidUser,
    required this.loginStatus,
    required this.subscribeInventory,
    required this.screen1,
    required this.screen2,
    required this.screen3,
    required this.screen4,
    required this.screen5,
    required this.screen6,
    required this.screen7,
  });

  List<Box> getScreen1BoxSetting() {
    return screen1.boxSettings;
  }
  List<Box> getScreen2BoxSetting() {
    return screen2.boxSettings;
  }
  List<Box> getScreen3BoxSetting() {
    return screen3.boxSettings;
  }
  List<Box> getScreen4BoxSetting() {
    return screen4.boxSettings;
  }

  int gettotalboxesScreen1(){
    return screen1.totalBoxes;
  }
  int gettotalboxesScreen2(){
    return screen2.totalBoxes;
  }
  int gettotalboxesScreen3(){
    return screen3.totalBoxes;
  }
  int gettotalboxesScreen4(){
    return screen4.totalBoxes;
  }

  String getcustomimageScreen1(){
    return screen1.emptyBoxCustomImage;
  }
  String getcustomimageScreen2(){
    return screen2.emptyBoxCustomImage;
  }
  String getcustomimageScreen3(){
    return screen3.emptyBoxCustomImage;
  }
  String getcustomimageScreen4(){
    return screen4.emptyBoxCustomImage;
  }



  String getEmptyBoxS1(){
    return screen1.emptyBox;
  }
  String getEmptyBoxS2(){
    return screen2.emptyBox;
  }
  String getEmptyBoxS3(){
    return screen3.emptyBox;
  }
  String getEmptyBoxS4(){
    return screen4.emptyBox;
  }


  String getRegion(){
    return region;
  }
  String getAccountType(){
    return accountType;
  }

  DateTime getCreatedAt(){
    return createdAt;
  }

  bool ispaidUser(){
    return isPaidUser;
  }
  String subscriptonExpires(){
    return subscriptionExpires;
  }
  bool loginstatus(){
    return loginStatus;
  }
}

