import 'package:flutter/material.dart';

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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    String _message;
    final controller = TextEditingController();

    @override
    void initState() {
      super.initState();
      _message = 'ok!';
    }
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('App Name'),
          ),
        body:
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Padding(
                child:
                  new Text(
                  _message,
                    style: new TextStyle(fontSize:32.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.all(20.0),
              ),
              new Padding(
                child:
                  new TextField(
                    controller: controller,
                    style: new TextStyle(fontSize:28.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"),
                  ),
                padding: const EdgeInsets.all(10.0),
              ),
              new FlatButton(key:null, onPressed:buttonPressed,
                child:
                  new Text(
                  "Push me !!!",
                    style: new TextStyle(fontSize:32.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"),
                  )
                )
            ]
          ),
      );
    }
    void buttonPressed(){
      setState(() {
        _message = "you said: " + controller.text;
      });
    }
}