import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Barcode extends StatefulWidget {
  @override
  _BarcodeState createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  final TextEditingController _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Attach the listener to onChanged event
    _textEditingController.addListener(() {
      // Check if the entered text has reached 14 characters
      if (_textEditingController.text.length == 14) {
        // Save the text to a variable
        String scannedBarcode = _textEditingController.text;
        // Do something with the scanned barcode (e.g., save it to a variable)
        print('Scanned Barcode: $scannedBarcode');
        // Clear the text in the TextFormField
        _textEditingController.clear();
      }
    });

    // Set initial focus on the TextFormField
    // _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Scan Bar Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/scanimagebanner.png',
              width: 250.0,
              height: 250.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Scan Lottery Ticket',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Scan the ticket that is going up for sale',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Scanned Bar Code',
                  border: OutlineInputBorder(),
                ),
                // focusNode: _focusNode,
                autofocus: true, // Set autofocus to true
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers and focus nodes to avoid memory leaks
    _textEditingController.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

}

