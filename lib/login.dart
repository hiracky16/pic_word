import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  FirebaseUser _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    this._email = '';
    this._password = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('PicWord'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                  child: new TextFormField(
                    controller: emailController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: new InputDecoration(
                        hintText: 'Email',
                        icon: new Icon(
                          Icons.mail,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                        value.isEmpty ? 'Email can\'t be empty' : null,
                    onChanged: (value) => _email = value.trim(),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                child: new TextFormField(
                  controller: passwordController,
                  maxLines: 1,
                  obscureText: true,
                  autofocus: false,
                  decoration: new InputDecoration(
                      hintText: 'Password',
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.grey,
                      )),
                  validator: (value) =>
                      value.isEmpty ? 'Password can\'t be empty' : null,
                  onChanged: (value) => _password = value.trim(),
                ),
              ),
              new MaterialButton(
                  key: null,
                  onPressed: signup,
                  color: Colors.blue,
                  elevation: 5.0,
                  minWidth: 200.0,
                  height: 42.0,
                  child: new Text(
                    "Sign up",
                    style: new TextStyle(
                        fontSize: 32.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  ),
              ),
              new MaterialButton(
                  key: null,
                  onPressed: signin,
                  color: Colors.blue,
                  elevation: 5.0,
                  minWidth: 200.0,
                  height: 42.0,
                  child: new Text(
                    "Sign in",
                    style: new TextStyle(
                        fontSize: 32.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  )
              )
            ]));
  }

  void signin() async {
    FirebaseUser user;
    try {
      user = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email, password: _password
      );
    } catch (e) {
      print(e.toString());
    }
    if (user != null) {
      setState(() {
        _user = user;
        _email = '';
        _password = '';
      });
      emailController.text = '';
      passwordController.text = '';
    }
    print('sign in');
    Navigator.of(context).pushNamed("/list");
  }

  void signup() async {
    FirebaseUser user;
    try {
      user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email, password: _password
      );
    } catch (e) {
      print(e.toString());
    }
    if (user != null) {
      setState(() {
        _user = user;
        _email = '';
        _password = '';
      });
      emailController.text = '';
      passwordController.text = '';
    }
    print('sign up');
    Navigator.of(context).pushNamed("/list");
  }
}
