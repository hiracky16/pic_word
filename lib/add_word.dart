import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddWord extends StatefulWidget {
  AddWord({Key key}) : super(key: key);
  @override
  _AddWordState createState() => new _AddWordState();
}

class _AddWordState extends State<AddWord> {
  String _word;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;
  final wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _word = '';
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('単語登録'),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new TextField(
              controller: wordController,
              onChanged: (value) => _word = value.trim(),
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

  void buttonPressed() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    var now = new DateTime.now();
    print(user.uid);
    print(_word);
    try {
      await _fireStore
        .collection('words')
        .document()
        .setData({'word': _word, 'user_id': user.uid, 'timestamp': now});
      setState(() {
        _word = '';
      });
      wordController.text = '';
    } catch (e) {
      print(e.toString());
    }
  }
}
