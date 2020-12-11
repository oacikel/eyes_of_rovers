import 'package:flutter/material.dart';

class NasaImageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image.network("https://s3.amazonaws.com/open-nasa-files/images/mars.original.png"),
    );
  }
}
