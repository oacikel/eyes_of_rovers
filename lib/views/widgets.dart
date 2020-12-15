import 'package:flutter/material.dart';

class BigMessageWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  BigMessageWidget(this.icon,this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              (Icon(icon,
              color: Colors.grey,
              size: 80,)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: (Text(message)),
              ),
            ],
          ),
        )
    );
  }
}
