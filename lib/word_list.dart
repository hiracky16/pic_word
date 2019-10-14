import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WordListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('単語リスト'),
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('words').snapshots(),
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
                            data['translated'] = {
                              'ja': '',
                              'en': ''
                            };
                          }
                          return new Card(
                              color: Colors.white,
                              elevation: 0.0,
                              child: ExpansionTile(
                                  title: Text(data['word']),
                                  children: <Widget>[
                                    new ListTile(
                                      title: Text(
                                          '日本語: ' + data['translated']['ja']
                                      )
                                    ),
                                    new ListTile(
                                      title: Text(
                                          '英語: ' + data['translated']['en']
                                      )
                                    )
                                  ]));
                        }).toList(),
                      );
                  }
                })));
  }
}
