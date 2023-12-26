import 'package:inventory_ios/Classes/Game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Preferences {
  // Function to save a string to SharedPreferences
  static Future<void> saveToPreferences(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> saveBoolToPreferences(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool> loadBoolFromPreferences(String key, {bool defaultValue = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<void> saveDateTimeToPreferences(String key, DateTime dateTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, dateTime.toIso8601String());
  }

  static Future<DateTime?> loadDateTimeFromPreferences(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? dateTimeString = prefs.getString(key);
    if (dateTimeString != null) {
      return DateTime.parse(dateTimeString);
    } else {
      return null;
    }
  }


  // Function to load a string from SharedPreferences
  static Future<String> loadStoredValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the stored value, defaulting to an empty string if not found
    return prefs.getString(key) ?? '';
  }

  static Future<void> saveIntToPreferences(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
  
  static Future<int> loadStoredIntValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the stored value, defaulting to 0 if not found
    return prefs.getInt(key) ?? 0;
  }


  static Future<void> saveGamesToSharedPreferences(List<Game> games) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Convert the list of games to a list of JSON maps
      final List<Map<String, dynamic>> gameJsonList = games.map((game) {
        return {
          'id': game.id,
          'name': game.name,
          'description': game.description,
          'image_url': game.imageUrl,
          'number': game.number,
          'ticket_value': game.ticketValue,
          'region': game.region,
          'pack_size': game.packSize,
          'is_active': game.isActive,
          'created_at': game.createdAt.toIso8601String(),
          // Convert DateTime to String
        };
      }).toList();

      // Save the list of JSON maps to SharedPreferences
      await prefs.setStringList(
        'gamesList',
        gameJsonList.map((json) => jsonEncode(json)).toList(),
      );
    } catch (e) {
      print('Error saving games to SharedPreferences: $e');
    }
  }



  static Future<List<Game>> loadGamesFromSharedPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve the list of JSON strings from SharedPreferences
      final List<String>? gameJsonList = prefs.getStringList('gamesList');

      print("gameliststring"+gameJsonList.toString());
      // Check if the list is not null before trying to use it
      if (gameJsonList != null) {
        // Convert the list of JSON strings back to a list of Game objects
        final List<Game> games = gameJsonList
            .map((json) => Game.fromJson(jsonDecode(json) as Map<String, dynamic>))
            .toList();
        return games;
      } else {
        return []; // Return an empty list if no data is found
      }
    } catch (e) {
      print('Error loading games from SharedPreferences: $e');
      return []; // Return an empty list in case of an error
    }
  }







  static Future<int> getGamesListSize() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve the list of JSON strings from SharedPreferences
      final List<String>? gameJsonList = prefs.getStringList('gamesList');

      // Check if the list is not null before trying to get its size
      if (gameJsonList != null) {
        return gameJsonList.length;
      } else {
        return 0; // Return 0 if the list is null or empty
      }
    } catch (e) {
      print('Error getting games list size from SharedPreferences: $e');
      return 0; // Return 0 in case of an error
    }
  }
}
