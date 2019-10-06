import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
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
    print(_email);
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
                child: new Text(
                  "Login Page",
                  style: new TextStyle(
                      fontSize: 32.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                ),
                padding: const EdgeInsets.all(20.0),
              ),
              new Padding(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "email:",
                        style: new TextStyle(
                            fontSize: 24.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      ),
                      new TextField(
                        onChanged: (text) {
                          setState(() {
                            this._email = text;
                          });
                        },
                        controller: emailController,
                        style: new TextStyle(
                            fontSize: 24.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      )
                    ]),
                padding: const EdgeInsets.all(10.0),
              ),
              new Padding(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "password:",
                        style: new TextStyle(
                            fontSize: 24.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      ),
                      new TextField(
                        onChanged: (text) {
                          this._password = text;
                        },
                        controller: passwordController,
                        style: new TextStyle(
                            fontSize: 24.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      )
                    ]),
                padding: const EdgeInsets.all(10.0),
              ),
              new RaisedButton(
                  key: null,
                  onPressed: buttonPressed,
                  color: const Color(0xFFe0e0e0),
                  child: new Text(
                    "Login",
                    style: new TextStyle(
                        fontSize: 32.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ))
            ]));
  }

  void buttonPressed() {
    print(_email);
    print(_password);
  }
}
