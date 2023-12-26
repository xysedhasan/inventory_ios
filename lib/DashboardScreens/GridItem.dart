import 'package:flutter/material.dart';
import 'package:inventory_ios/Activity/UpdateTicket.dart';
import '../Classes/UserNew.dart';

class GridItem extends StatelessWidget {
  final Box box;
  final int index;
  final String boximage;
  final Stream<String> imageStream;

  GridItem(this.box, this.index, this.boximage, this.imageStream);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateTicket(box: box, indexnum: index),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${index}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _buildGameImage(box.game_image),
            SizedBox(height: 8.0),
            Text(
              '${box.game_no}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Add more properties of Box as needed
          ],
        ),
      ),
    );
  }

  Widget _buildGameImage(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? Image.network(
      imageUrl,
      width: 70.0,
      height: 70.0,
    )
        : Image.asset(
      'assets/image/emptyimage.png',
      width: 70.0,
      height: 70.0,
    );
  }
}
