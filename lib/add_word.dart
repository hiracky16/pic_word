import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pic_word/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pic_word/models/login.dart';
import 'package:pic_word/models/word.dart';

class AddWord extends StatefulWidget {
  AddWord({Key key}) : super(key: key);
  @override
  _AddWordState createState() => new _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;
  final wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('単語登録'),
        ),
        drawer: buildDrawer(context),
        body: Consumer2<Login, Word>(builder: (context, login, word, _) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: new TextField(
                      decoration: InputDecoration(
                          labelText: '登録単語', border: OutlineInputBorder()),
                      controller: wordController,
                      style: new TextStyle(
                          fontSize: 24.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto"),
                      onChanged: (value) => word.setWord(value),
                    )),
                Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: new MaterialButton(
                        key: null,
                        onPressed: () => {
                          print(login.user),
                          print(word.word),
                          buttonPressed(word.word, login.user.uid)
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        elevation: 5.0,
                        minWidth: 200.0,
                        height: 60.0,
                        child: new Text(
                          "登録",
                          style: new TextStyle(
                              fontSize: 22.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto"),
                        )))
              ]);
        }));
  }

  void buttonPressed(String word, String uid) async {
    var now = new DateTime.now();
    try {
      await _fireStore
          .collection('users')
          .document(uid)
          .collection('words')
          .document()
          .setData({'word': word, 'user_id': uid, 'timestamp': now});
      wordController.text = '';
    } catch (e) {
      print(e.toString());
    }
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

  @override
  _Button(this.onPress, this.color, this.btnText);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        key: null,
        onPressed: () {
          onPress(context);
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
