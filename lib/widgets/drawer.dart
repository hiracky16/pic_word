import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
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
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/login');
          },
        ),
        Divider(),
        ListTile(
          title: Text('単語リスト'),
          onTap: () {
            Navigator.pushNamed(context, '/list');
          },
        ),
        ListTile(
          title: Text('カメラ'),
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
      ],
    ),
  );
}
