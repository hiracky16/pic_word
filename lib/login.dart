import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pic_word/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pic_word/models/login.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text('会員登録 / ログイン'),
        ),
        drawer: buildDrawer(context),
        body: Consumer<Login>(builder: (context, login, _) {
          return Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _InputText(
                            _emailController,
                            TextInputType.emailAddress,
                            false,
                            'Email',
                            Icons.mail,
                            validateEmail,
                            login.setEmail)),
                    Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _InputText(
                            _passwordController,
                            null,
                            true,
                            'Password',
                            Icons.lock,
                            validatePass,
                            login.setPassword)),
                    Padding(
                      child: _Button(signup, Colors.lightBlue, "登録", login),
                      padding: const EdgeInsets.all(24.0),
                    ),
                    Padding(
                      child: _Button(signin, Colors.blue, "ログイン", login),
                      padding: const EdgeInsets.all(24.0),
                    )
                  ]));
        }));
  }

  String validateEmail(String email) {
    return email.isEmpty ? 'メールアドレスを入力してください。' : null;
  }

  String validatePass(String password) {
    String message = '';
    if (password.isEmpty) {
      message += 'パスワードを入力してくだい。';
    }
    if (password.length < 6) {
      message += 'パスワードは6文字以上です。';
    } else {
      return null;
    }
    return message;
  }

  void signin(BuildContext context, String email, String password) async {
    FirebaseUser user;
    // form のバリデーションを実行
    _formKey.currentState.validate();
    try {
      user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return;
    }
    print('sign in');
    Navigator.pushNamed(context, "/list");
  }

  void signup(BuildContext context, String email, String password) async {
    FirebaseUser user;
    _formKey.currentState.validate();
    try {
      user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return;
    }
    print('sign up');
    Navigator.pushNamed(context, "/list");
  }

  void showBasicDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text(message),
        content: new Text("もう一度お試しください。"),
        // ボタンの配置
        actions: <Widget>[
          new FlatButton(
              child: const Text('戻る'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}

class _InputText extends StatelessWidget {
  TextInputType type;
  bool isObscureText;
  String hintText;
  IconData icon;
  Function validator;
  Function change;
  TextEditingController _textEditingController;
  _InputText(this._textEditingController, this.type, this.isObscureText,
      this.hintText, this.icon, this.validator, this.change);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      maxLines: 1,
      obscureText: isObscureText,
      keyboardType: type,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: hintText,
          icon: new Icon(
            icon,
            color: Colors.grey,
          )),
      validator: (value) {
        String message = validator(value);
        return message;
      },
      onChanged: (value) {
        change(value);
      },
    );
  }
}

class _Button extends StatelessWidget {
  final Function onPress;
  final MaterialColor color;
  final String btnText;
  final Login login;

  @override
  _Button(this.onPress, this.color, this.btnText, this.login);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        key: null,
        onPressed: () {
          onPress(context, login.email, login.password);
        },
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        elevation: 5.0,
        minWidth: 200.0,
        height: 60.0,
        child: new Text(
          btnText,
          style: new TextStyle(
              fontSize: 22.0,
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto"),
        ));
  }
}
