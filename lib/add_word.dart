import 'package:flutter/material.dart';

class AddWord extends StatefulWidget {
  AddWord({Key key}) : super(key: key);
  @override
  _AddWordState createState() => new _AddWordState();
}

class _AddWordState extends State<AddWord> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Word'),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new TextField(
              style: new TextStyle(
                  fontSize: 32.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto"),
            ),
            new RaisedButton(
                key: null,
                onPressed: buttonPressed,
                color: const Color(0xFFe0e0e0),
                child: new Text(
                  "登録",
                  style: new TextStyle(
                      fontSize: 32.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                ))
          ]),
    );
  }

  void buttonPressed() {}
}
