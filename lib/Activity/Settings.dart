import 'package:flutter/material.dart';
import 'package:inventory_ios/Classes/preferences.dart';
import 'package:inventory_ios/SettingsScreen/Screen1.dart';
import 'package:inventory_ios/SettingsScreen/Screen2.dart';
import 'package:inventory_ios/SettingsScreen/Screen3.dart';
import 'package:inventory_ios/SettingsScreen/Screen4.dart';

class Settings extends StatefulWidget {
  final List<String> screenNames;
  final Function(String) onScreenChange;

  const Settings({
    required this.screenNames,
    required this.onScreenChange,
  });

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Define a variable to store the current screen index
  int _selectedIndex = 0;
  int _tabLength = 0;

  // Define a map to store screens
  final Map<int, WidgetBuilder> _screensMap = {};

  @override
  void initState() {
    super.initState();

    getAccountType().then((accountType) {
      if (accountType == "A1") {
        _tabLength = 1;
      } else if (accountType == "B2") {
        _tabLength = 2;
      } else if (accountType == "C3") {
        _tabLength = 3;
      } else if (accountType == "D4") {
        _tabLength = 4;
      }
      setState(() {}); // Update state after async operation
    });
    _populateScreensMap();
  }

  void _populateScreensMap() {
    for (int i = 0; i < widget.screenNames.length; i++) {
      switch (i) {
        case 0:
          _screensMap[i] = (context) => Screen1(index: i + 1);
          break;
        case 1:
          _screensMap[i] = (context) => Screen2(index: i + 1);
          break;
        case 2:
          _screensMap[i] = (context) => Screen3(index: i + 1);
          break;
        case 3:
          _screensMap[i] = (context) => Screen4(index: i + 1);
          break;
        default:
          _screensMap[i] = (context) => Text('Invalid Screen');
      }
    }
  }

  Future<String> getAccountType() async {
    return Preferences.loadStoredValue("accounttype");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          // Chip buttons section
          Wrap(
            spacing: 8.0,
            children: [
              for (int i = 0;
                  i < _tabLength;
                  i++) // Limit loop based on _tabLength
                ChoiceChip(
                  label: Text(widget.screenNames[i]),
                  selected: _selectedIndex == i,
                  onSelected: (selected) {
                    setState(() {
                      _selectedIndex = i;
                    });
                  },
                ),
            ],
          ),

          // Screens section
          Expanded(
            child: _screensMap[_selectedIndex]!(context),
          ),
        ],
      ),
    );
  }
}


