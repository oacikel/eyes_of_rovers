import 'package:eyes_of_rovers/model/model.dart';
import 'package:eyes_of_rovers/views/widgets.dart';
import 'package:flutter/material.dart';

class NasaImageTile extends StatelessWidget {
  final _url;

  NasaImageTile(this._url);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: 'zeroToHero',
        child: Card(
          child: Image.network(
            _url,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
        ),
      ),
      onTap: (){
        showDialog(context: context,
            barrierDismissible: true,
            builder: (_){
          return Container(
            //height: 300,
            child: BigPhoto(_url)
          );
            });
        },
    );
  }
}
