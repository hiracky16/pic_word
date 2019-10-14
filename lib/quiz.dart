import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _count;
  @override
  void initState() {
    _count = 1;
    super.initState();
    print('count:' + _count.toString());
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('クイズ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('words').snapshots(),
        builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
            default:
              var random = new Random();
              snapshot.data.documents.shuffle(random);
              var word1 = snapshot.data.documents[0].data;
              var word2 = snapshot.data.documents[1].data;
              String ja1 = word1.containsKey('translated') ? word1['translated']['ja'] : '日本';
              String ja2 = word2.containsKey('translated') ? word2['translated']['ja'] : '日本';
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(
                      _count.toString() + '回目',
                      style: new TextStyle(
                            fontSize: 24.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto")
                    ),
                    new Padding(
                      child: new Text(
                        word1['word'],
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 48.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.all(35.0),
                    ),
                    new Padding(
                      child: new MaterialButton(
                          elevation: 5.0,
                          minWidth: 200.0,
                          height: 60.0,
                          key: null,
                          onPressed: buttonPressed,
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: new Text(
                            '1. ' + ja1,
                            style: new TextStyle(
                                fontSize: 24.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          )),
                      padding: const EdgeInsets.all(24.0),
                    ),
                    new Padding(
                      child: new MaterialButton(
                          elevation: 5.0,
                          minWidth: 200.0,
                          height: 60.0,
                          key: null,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          onPressed: buttonPressed,
                          child: new Text(
                            '2. ' + ja2,
                            style: new TextStyle(
                                fontSize: 24.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          )),
                      padding: const EdgeInsets.all(24.0),
                    )
                  ]
                );
            }
        })
    );
  }

  void buttonPressed() {
    setState(() {
      _count = _count++;
    });
    print(_count);
    // Navigator.of(context).pushNamed("/quiz");
  }
}
