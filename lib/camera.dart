import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:pic_word/detail_widget.dart';
import 'package:pic_word/widgets/drawer.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("文字読み取り"),
      ),
      drawer: buildDrawer(context),
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
                padding: const EdgeInsets.all(24.0),
                child: new MaterialButton(
                  key: null,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  elevation: 5.0,
                  minWidth: 200.0,
                  height: 60.0,
                  onPressed: () {
                    _onPickImageSelected(context);
                  },
                  child: Text("カメラを開く\n注:英語限定"),
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
      Navigator.of(context).pushNamed("/list");
    }
  }

}