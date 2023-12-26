import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_ios/Classes/Preferences.dart';
import 'package:logger/logger.dart';

class Game {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String number;
  final String ticketValue;
  final String region;
  final String packSize;
  final bool isActive;
  final DateTime createdAt;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.number,
    required this.ticketValue,
    required this.region,
    required this.packSize,
    required this.isActive,
    required this.createdAt,
  });

  factory Game.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Game(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['image_url'] ?? '',
      number: data['number'] ?? '',
      ticketValue: data['ticket_value'] ?? '',
      region: data['region'] ?? '',
      packSize: data['pack_size'] ?? '',
      isActive: data['is_active'] ?? false,
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  // Convert a Game object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'description': description,
      'imageUrl': imageUrl,
      'number': number,
      'ticketValue': ticketValue,
      'region': region,
      'packSize': packSize,
      'isActive': isActive,
      'createdAt': createdAt
    };
  }

  // Create a Game object from a JSON map
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        name: json['name'],
        id: json['id'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        number: json['number'],
        ticketValue: json['ticketValue'],
        region: json['region'],
        packSize: json['packSize'],
        isActive: json['isActive'],
        createdAt: json['createdAt']);
  }
}

class GameRepository {
  final CollectionReference gamesCollection =
      FirebaseFirestore.instance.collection('games');

  // .where('region', isEqualTo: 'Arkansas').get();



  Future<List<Game>> queryGamesInTexas() async {
    try {
      String region = await Preferences.loadStoredValue("region");

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('games')
          .where('region', isEqualTo: region)
          .get();

      List<Game> games = querySnapshot.docs.map((doc) {
        return Game.fromFirestore(doc);
      }).toList();
      return games;
    } catch (e) {

      var logger = Logger();
      logger.d('This is a log error . + $e');
      print('Error querying games in Texas: $e');
      return [];
    }
  }

  Future<List<Game>> getGames() async {
    try {
      final QuerySnapshot querySnapshot = await gamesCollection.get();
      return querySnapshot.docs.map((doc) => Game.fromFirestore(doc)).toList();
    } catch (e) {
      var logger = Logger();
      logger.d('This is a log error.');
      logger.d(await Preferences.loadStoredValue("region"));
      print('Error fetching games: $e');
      return [];
    }
  }
}
