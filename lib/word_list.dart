import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pic_word/widgets/drawer.dart';

class WordListPage extends StatefulWidget {
  WordListPage({Key key}) : super(key: key);
  @override
  _WordListState createState() => new _WordListState();
}

class _WordListState extends State<WordListPage> {
  String _userId;
  final Firestore _fireStore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    this.initUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('単語リスト'),
        ),
        drawer: buildDrawer(context),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('users')
                    .document(_userId)
                    .collection('words')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          var data = document.data;
                          if (!data.containsKey('translated')) {
                            data['translated'] = {'ja': '', 'en': '', 'zh': ''};
                          }
                          return new Card(
                              color: Colors.white,
                              elevation: 0.0,
                              child: ExpansionTile(
                                  title: Text(data['word']),
                                  children: <Widget>[
                                    new ListTile(
                                        title: Text('日本語: ' +
                                            data['translated']['ja'])),
                                    new ListTile(
                                        title: Text(
                                            '英語: ' + data['translated']['en'])),
                                    new ListTile(
                                        title: Text(
                                            '中国語: ' + data['translated']['zh']))
                                  ]));
                        }).toList(),
                      );
                  }
                })));
  }

  void initUserId() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await _firebaseAuth.currentUser();
    String uid = user.uid;
    setState(() {
      _userId = uid;
    });
  }
}
