import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget buildDrawer(BuildContext context) {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'PicWord',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('単語リスト'),
          onTap: () {
            Navigator.pushNamed(context, '/list');
          },
        ),
        ListTile(
          title: Text('カメラで登録'),
          onTap: () {
            Navigator.pushNamed(context, '/camera');
          },
        ),
        ListTile(
          title: Text('単語登録'),
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
        ListTile(
          title: Text('クイズ'),
          onTap: () {
            Navigator.pushNamed(context, '/quiz');
          },
        ),
        ListTile(
          title: Text('ログアウト'),
          onTap: () {
            _firebaseAuth.signOut();
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    ),
  );
}
