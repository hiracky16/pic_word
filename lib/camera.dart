import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:pic_word/detail_widget.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("文字読み取り"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _startCamera(context),
          ],
        ),
      ),
    );
  }

  Widget _startCamera(context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    _onPickImageSelected(context);
                  },
                  child: Text("start camera"),
                )),
          ),
        ],
      ),
    );
  }

  void _onPickImageSelected(context) async {

    var imageSource = ImageSource.camera;

    try {
      final file =
      await ImagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('ファイルを取得できませんでした');
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailWidget(file)));
    } catch(e) {
    }
  }

}