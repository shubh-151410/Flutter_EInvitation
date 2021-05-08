import 'package:dio/dio.dart';
import 'package:e_invitation/Model/saved_card_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart' as colors;
import 'SavedCardFullScreen.dart';

class GetSavedCard extends StatefulWidget {
  @override
  _SavedCardState createState() => _SavedCardState();
}

class _SavedCardState extends State<GetSavedCard> {
  double _height = 0.0;

  double _width = 0.0;
  Future<SaveCardModel> saveCardModel() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userId = preferences.getString("USER_ID");
      SaveCardModel saveCardModel = SaveCardModel();
      Response response = await Dio()
          .get("http://pearl.tradeguruweb.com/api/v1/getallsavecard/$userId");

      saveCardModel = SaveCardModel.fromJson(response.data);

      return saveCardModel;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.mainbgColor,
        centerTitle: true,
        title: Text("Save Card"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          height: _height,
          width: _width,
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: FutureBuilder<SaveCardModel>(
            future: saveCardModel(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // if(snapshot.)

                return (snapshot.data.data != null)
                    ? GridView.count(
                        crossAxisCount: 3,
                        // childAspectRatio: 9 / 8,
                        padding: EdgeInsets.only(bottom: 10.0),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        shrinkWrap: true,
                        children: snapshot.data.data.map((e) {
                          int index = snapshot.data.data.indexOf(e);
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetSavedCardFullScreen(
                                    url:
                                        "http://pearl.tradeguruweb.com/${snapshot.data.data[index].cardUrl}",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                // color: e,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "http://pearl.tradeguruweb.com/${snapshot.data.data[index].cardUrl}"),
                                    fit: BoxFit.cover),
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          );
                        }).toList())
                    : Container(
                        child: Center(
                          child: Text("No Card Has been Saved"),
                        ),
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
