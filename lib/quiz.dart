import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _count;
  int _successCount;
  String _userId;
  List<String> candidates = <String>[];
  String ans;

  @override
  void initState() {
    _count = 0;
    _successCount = 0;
    super.initState();
    ans = '';
    initUserId();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('クイズ'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(_userId)
                .collection('words')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  var word3 = snapshot.data.documents[2].data;
                  var word4 = snapshot.data.documents[4].data;
                  String ja1 = word1.containsKey('translated')
                      ? word1['translated']['ja']
                      : '入力されていません';
                  String ja2 = word2.containsKey('translated')
                      ? word2['translated']['ja']
                      : '入力されていません';
                  String ja3 = word3.containsKey('translated')
                      ? word3['translated']['ja']
                      : '入力されていません';
                  return new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(_count.toString() + '回目',
                            style: new TextStyle(
                                fontSize: 24.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto")),
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
                        _answerButton(ja1, 1),
                        _answerButton(ja2, 2),
                        _answerButton(ja3, 3),
                      ]);
              }
            }));
  }

  Widget _answerButton(String text, int index) {
    return new Padding(
      child: new MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 60.0,
          key: null,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          onPressed: () {
            buttonPressed(index);
          },
          child: new Text(
            index.toString() + '. ' + text,
            style: new TextStyle(
                fontSize: 24.0,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto"),
          )),
      padding: const EdgeInsets.all(24.0),
    );
  }

  void initUserId() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await _firebaseAuth.currentUser();
    setState(() {
      _userId = user.uid;
    });
  }

  void showBasicDialog(BuildContext context) {
    double rate = _successCount / _count * 100;
    String comment = rate > 50 ? 'よく頑張りました' : 'もう少し頑張りましょう';
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text("正解率: " + rate.toString() + "%"),
        content: new Text(comment),
        // ボタンの配置
        actions: <Widget>[
          new FlatButton(
              child: const Text('戻る'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/list");
              })
        ],
      ),
    );
  }

  void buttonPressed(int index) {
    setState(() {
      _count += 1;
    });
    if (index == 1) {
      setState(() {
        _successCount += 1;
      });
    }
    print(_successCount);
    if (_count >= 20) {
      showBasicDialog(context);
      // Navigator.of(context).pushNamed("/list");
    }
  }
}

enum _DialogActionType {
  cancel,
  ok,
}
