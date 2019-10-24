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
  String locale;

  @override
  void initState() {
    _count = 1;
    _successCount = 0;
    super.initState();
    locale = 'zh';
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
                  if (snapshot.data.documents.length < 10) {
                    return new Text('登録単語が少なすぎるためクイズは使用できません。\n10 単語以上の登録が必要になります');
                  }
                  var random = new Random();
                  snapshot.data.documents.shuffle(random);
                  var words = snapshot.data.documents.sublist(0, 3);
                  int ansIndex = random.nextInt(3);
                  String ja1 = words[0].data.containsKey('translated')
                      ? words[0].data['translated']['ja']
                      : '入力されていません';
                  String ja2 = words[1].data.containsKey('translated')
                      ? words[1].data['translated']['ja']
                      : '入力されていません';
                  String ja3 = words[2].data.containsKey('translated')
                      ? words[2].data['translated']['ja']
                      : '入力されていません';
                  print(words[ansIndex].data['translated'][locale]);
                  return new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('言語: '),
                              selectBox()
                            ]
                          )
                        ),
                        new Text(
                          _count.toString() + '問目',
                          style: new TextStyle(
                              fontSize: 24.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto"),
                          textAlign: TextAlign.center,
                        ),
                        new Padding(
                          child: new Text(
                            words[ansIndex].data['translated'][locale] != null
                                ? words[ansIndex].data['translated'][locale]
                                : 'Loading...',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: 48.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto"),
                          ),
                          padding: const EdgeInsets.all(35.0),
                        ),
                        _answerButton(ja1, 0, ansIndex),
                        _answerButton(ja2, 1, ansIndex),
                        _answerButton(ja3, 2, ansIndex),
                      ]);
              }
            }));
  }

  Widget _answerButton(String text, int index, int ansIndex) {
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
            buttonPressed(index, ansIndex);
          },
          child: new Text(
            (index + 1).toString() + '. ' + text,
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

  void buttonPressed(int index, int ansIndex) {
    setState(() {
      _count += 1;
    });
    if (index == ansIndex) {
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

  Widget selectBox() {
    var localeMap = {'ja': '日本語', 'zh': '中国語', 'en': '英語'};
    return DropdownButton<String>(
        value: locale,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (String newValue) {
          setState(() {
            locale = newValue;
          });
        },
        items: <String>['zh', 'ja', 'en']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(localeMap[value]),
          );
        }).toList());
  }
}
