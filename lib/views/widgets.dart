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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
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
                debugPrint("${LOG_TAG+widget._currentSol.toString()}");
                widget.streamController.add(int.parse(numberController.text));
              },
            ),
          ],
        ),
      ),
    );
  }
  void _updateSol(int sol){
    setState(() {
      widget._currentSol = sol;
    });
  }
}
