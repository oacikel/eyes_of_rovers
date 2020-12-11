import 'package:eyes_of_rovers/views/nasa_image_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NasaImageWidget extends StatelessWidget {
  final Key key;

  NasaImageWidget(this.key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      primary: false,
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemBuilder: (BuildContext context, int index) => new Container(
          child: new Center(
            child: NasaImageTile(),
          )
      ),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
    );
  }
}
