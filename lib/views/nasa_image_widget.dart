import 'package:eyes_of_rovers/model/model.dart';
import 'package:eyes_of_rovers/views/nasa_image_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NasaImageWidget extends StatelessWidget {
  final Key key;
  final List<NasaImage> photos;

  NasaImageWidget(this.key,this.photos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: new StaggeredGridView.countBuilder(
          crossAxisCount:4,
          itemCount: photos.length,
          itemBuilder: (BuildContext context, int index)=>NasaImageTile(photos[index].photoUrl),
        staggeredTileBuilder: (int index)=>
        StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      )
    );
  }
}
