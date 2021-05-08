import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart' as colors;

class ViewImage extends StatefulWidget {
  String filedata;
  var content;
  String categoryId;
  String qrid;
  String type;
  String createCardPath;
  String bgImageUrl;
  String qrCode = "";
  String userType;

  ViewImage(
      {this.filedata,
      this.content,
      this.categoryId,
      this.qrid,
      this.type,
      String imagefile,
      this.createCardPath,
      this.bgImageUrl,
      this.qrCode = "",
      this.userType});
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  double _height = 0.0;
  double _width = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  var content = [
    {
      "text": "Durgesh Pandey",
      "size": "18",
      "font-style": "bold",
      "x": "150",
      "y": "150",
      "font-family": "Times New Roman",
      "color": "#000000"
    },
    {
      "text": "Durgesh Pandey",
      "size": "18",
      "font-style": "bold",
      "x": "250",
      "y": "150",
      "font-family": "Times New Roman",
      "color": "#000000"
    }
  ];
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: colors.mainbgColor,
      floatingActionButton: (widget.userType.isEmpty)
          ? FloatingActionButton(
              backgroundColor: colors.mainAlertDialogbgColor,
              child: Icon(Icons.share),
              onPressed: () {
                Share.shareFiles([widget.filedata]);
              },
            )
          : Container(),
      body: Column(
        // mainAxisAlignment: MainA,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: _width * 0.05, right: _width * 0.05, top: _height * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: ImageIcon(
                      AssetImage(
                        "assets/backarrow.png",
                      ),
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Column(
                  children: [
                    Text(
                      'The Pearl',
                      style: TextStyle(
                        fontFamily: 'Butterfly-Kiss---Personal-Use',
                        fontSize: 25,
                        color: const Color(0xffffffff),
                        height: 0.84,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'EVENTS',
                      style: TextStyle(
                        fontFamily: 'DIN-Medium',
                        fontSize: 6,
                        color: const Color(0xffffffff),
                        letterSpacing: 2.4000000000000004,
                        height: 0.8333333333333334,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                InkWell(
                    onTap: () {
                      try {
                        (widget.userType.isEmpty)
                            ? uploadUserCard()
                            : uploadAdminCard();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Image.file(
                File(widget.filedata),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadAdminCard() async {
    List<ContentModel> listContentModel = List();

    try {
      List<int> imageBytes = File(widget.createCardPath).readAsBytesSync();
      // print(imageBytes);
      String base64Image = base64Encode(imageBytes);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("USER_ID");
      widget.content.forEach((value) {
        ContentModel contentModel = ContentModel();

        contentModel.fontFamily = value['OpenSans'];
        contentModel.color = value['color'];
        contentModel.fontStyle =
            (value['fontStyle'] == FontStyle.normal) ? "normal" : "italic";
        contentModel.size = value["fontSize"].toString();
        contentModel.x = value['xAxis'].toString();
        contentModel.y = value['yAxis'].toString();
        contentModel.text = value['text'].toString();

        listContentModel.add(contentModel);
      });

      print(listContentModel);

      List<Map<String, dynamic>> jsonData =
          listContentModel.map((word) => word.toJson()).toList();
      print(jsonEncode(jsonData));

      var dio = Dio();

      var mapData = {
        "user_id": userId,
        "image": base64Image,
        "category_id": widget.categoryId,
        "content": jsonEncode(jsonData),
      };

      print(mapData);
      var response = await dio.post(
          "http://pearl.tradeguruweb.com/api/v1/getuploadcardbyadmin",
          data: mapData);

      if (response.data['status'] == "true") {
        _scaffoldkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: 40,
            child: Text("${response.data['message']}"),
          ),
        ));

        _scaffoldkey.currentState.hideCurrentSnackBar();
      }

      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  uploadUserCard() async {
    try {
      List<int> imageBytes =
          await File(widget.createCardPath).readAsBytesSync();
      // print(imageBytes);
      String base64Image = base64Encode(imageBytes);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("USER_ID");

      print(userId);

      var dio = Dio();
      var mapData = {
        "user_id": userId,
        "image": base64Image,
        "category_id": widget.categoryId,
      };

      print(mapData);
      var response = await dio.post(
          "http://pearl.tradeguruweb.com/api/v1/getuploadcardimage",
          data: mapData);

      if (response.data['status'] == "true") {
        _scaffoldkey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Container(
            height: 40,
            child: Text("${response.data['message']}"),
          ),
        ));
        // _scaffoldkey.currentState.hideCurrentSnackBar();
      }

      print(response.data);
    } catch (e) {
      print(e);
    }
  }
}

class ContentModel {
  String text;
  String size;
  String fontStyle;
  String x;
  String y;
  String fontFamily;
  String color;

  ContentModel(
      {this.text,
      this.size,
      this.fontStyle,
      this.x,
      this.y,
      this.fontFamily,
      this.color});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['size'] = this.size;
    // ignore: unrelated_type_equality_checks
    data['font-style'] = this.fontStyle;
    data['x'] = this.x;
    data['y'] = this.y;
    data['font-family'] = this.fontFamily;
    data['color'] = this.color;
    return data;
  }
}

//  constant.FontFamily: 'OpenSans',
//                             constant.COLOR: "FFFFFF",
//                             constant.FONTSTYLE: FontStyle.normal,
//                             constant.FONTSIZE: 22.0,
//                             constant.FONTWEIGHT: FontWeight.normal,
//                             constant.DECORATION: TextDecoration.none,
//                             constant.xPostion: 0.0,
//                             constant.yPosition: 0.0,
//                             constant.OPACITY: 1.0,
//                             constant.BLUR: 0.0,
