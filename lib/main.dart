import 'package:flutter/material.dart';
import 'package:pic_word/login.dart';
import 'package:pic_word/add_word.dart';
import 'package:pic_word/camera.dart';
import 'package:pic_word/word_list.dart';
import 'package:pic_word/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:pic_word/models/login.dart';
import 'package:pic_word/models/word.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isLogin;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    isLogin = _firebaseAuth.currentUser() != null;
    print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider<Login>(
              builder: (_) => Login(),
            ),
            ChangeNotifierProvider<Word>(
              builder: (_) => Word(),
            ),
          ],
          child: new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Generated App',
            theme: new ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: const Color(0xFF2196f3),
              accentColor: const Color(0xFF2196f3),
              canvasColor: const Color(0xFFfafafa),
            ),
            home: LoginPage(),
            routes: <String, WidgetBuilder>{
              '/register': (_) => new AddWord(),
              '/login': (_) => new LoginPage(),
              '/camera': (_) => new Camera(),
              '/list': (_) => new WordListPage(),
              '/quiz': (_) => new QuizPage()
            },
          )
    );
  }

  Widget returnHomePage() {
    return isLogin ? new WordListPage() : new LoginPage();
  }
}
