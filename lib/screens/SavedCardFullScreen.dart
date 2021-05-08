import 'package:dio/dio.dart';
import 'package:e_invitation/Model/saved_card_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart' as colors;

class GetSavedCardFullScreen extends StatefulWidget {
  String url;
  GetSavedCardFullScreen({this.url});
  @override
  _SavedCardStateFullScreen createState() => _SavedCardStateFullScreen();
}

class _SavedCardStateFullScreen extends State<GetSavedCardFullScreen> {
  double _height = 0.0;

  double _width = 0.0;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
       floatingActionButton:  FloatingActionButton(
              backgroundColor: colors.mainAlertDialogbgColor,
              child: Icon(Icons.share),
              onPressed: () {
                Share.share(widget.url);
              },
            ),
         
        appBar: AppBar(
          backgroundColor: colors.mainbgColor,
          centerTitle: true,
          title: Text("Share Card"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(child: Image.network(widget.url)));
  }
}
