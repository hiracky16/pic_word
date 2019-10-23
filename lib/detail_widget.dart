import 'dart:async';
import 'dart:io';
import 'package:pic_word/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:mlkit/mlkit.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this._file);

  final File _file;

  @override
  _DetailWidgetState createState() => new _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  FirebaseVisionTextDetector _detector = FirebaseVisionTextDetector.instance;
  List<VisionText> _currentTextLabels = <VisionText>[];

  @override
  void initState() {
    super.initState();

    Timer(Duration(microseconds: 1000), () {
      this._analyzeLabels();
    });
  }

  _analyzeLabels() async {
    try {
      var currentTextLabels = await _detector.detectFromPath(widget._file.path);
      setState(() {
        _currentTextLabels = currentTextLabels;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("文字読み取り"),
        ),
        drawer: buildDrawer(context),
        body: Column(
          children: <Widget>[
            _buildTextList(_currentTextLabels)
          ],
        ));
  }

  Widget _buildTextList(List<VisionText> texts) {
    if (texts.length == 0) {
      return Expanded(
          flex: 1,
          child: Center(
            child: Text('No text detected',
                style: Theme.of(context).textTheme.subhead),
          ));
    }

    return Expanded(
      flex: 1,
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return _buildTextRow(texts[i].text);
            }),
      ),
    );
  }

  Widget _buildTextRow(text) {
    return ListTile(
      title: Text(
        "$text",
      ),
      dense: true,
    );
  }
}