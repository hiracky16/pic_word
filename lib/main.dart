import 'package:flutter/material.dart';
import 'package:pic_word/login.dart';
import 'package:pic_word/add_word.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new LoginPage(),
      routes: <String, WidgetBuilder>{
      '/register': (_) => new AddWord(),
      '/login': (_) => new LoginPage(),
    },
    );
  }
}
