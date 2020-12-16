import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BigMessageWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  BigMessageWidget(this.icon, this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (Icon(
            icon,
            color: Colors.grey,
            size: 80,
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: (Text(
              message,
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    ));
  }
}

class SolDayPicker extends StatefulWidget {
  int _currentSol;
  final StreamController<int> streamController;
  SolDayPicker( this.streamController,this._currentSol);

  @override
  _SolDayPickerState createState() => _SolDayPickerState();
}

class _SolDayPickerState extends State<SolDayPicker> {
  final String LOG_TAG ="OCULCAN - SolDayPicker: ";

  TextEditingController numberController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize:MainAxisSize.min,
            children: [
              Text(
                "Current sol is ${widget._currentSol}.",
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: numberController,
                decoration: new InputDecoration(
                    labelText: "Enter another sol to be searched"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
              RaisedButton(
                child: Text("Go!"),
                onPressed: () {
                  widget.streamController.add(int.parse(numberController.text));
                  Navigator.maybePop(context,false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BigPhoto extends StatelessWidget {
  String _url;

  BigPhoto(this._url);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
       width: 500,
       height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(_url),
                fit: BoxFit.contain
            )
        ),
      ),
    );
  }
}

