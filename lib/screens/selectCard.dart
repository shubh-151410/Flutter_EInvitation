import 'dart:convert';

import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/Model/sticker_model.dart';
import 'package:e_invitation/screens/newsavedcard.dart';
import 'package:e_invitation/screens/savecard.dart';
import 'package:e_invitation/screens/savedCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../utils/colors.dart' as colors;
import '../utils/widget.dart' as commonDrawer;

class SelectCard extends StatefulWidget {
  StickerModel stickerModel = StickerModel();
  SelectCard({this.stickerModel});
  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  double _height = 0.0;
  double _width = 0.0;
  ApiRemote apiRemote = ApiRemote();
  String userName = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String imageUrl = "http://pearl.tradeguruweb.com/";

  @override
  void initState() {
    apiRemote.getReadyCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    commonDrawer.getUserName().then((value) {
      userName = value;
      setState(() {});
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.mainbgColor,
      drawer: commonDrawer.commonDrawer(userName, context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: _height * 0.06),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: _width * 0.05, right: _width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: ImageIcon(
                      AssetImage("assets/backarrow.png"),
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Image.asset("assets/drawericon.png"))
                ],
              ),
            ),
            Divider(color: Colors.white),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: _width * 0.05,
                  right: _width * 0.05,
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Card',
                          style: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            fontSize: 20,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'Filter',
                        //       style: TextStyle(
                        //         fontFamily: 'Helvetica Neue',
                        //         fontSize: 12,
                        //         color: const Color(0xffffffff),
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //       textAlign: TextAlign.left,
                        //     ),
                        //     SizedBox(width: 8.0),
                        //     Image.asset("assets/filterIcon2.png")
                        //   ],
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Observer(builder: (context) {
                      return (apiRemote.readyCard.status != null)
                          ? GridView.count(
                              physics: NeverScrollableScrollPhysics(),

                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              // childAspectRatio: 9 / 8,
                              padding: const EdgeInsets.all(0.0),
                              crossAxisSpacing: 3.0,
                              mainAxisSpacing: 10.0,
                              shrinkWrap: true,
                              children: apiRemote.readyCard.data.map((e) {
                                int index = apiRemote.readyCard.data.indexOf(e);
                                return GridTile(
                                    child: InkWell(
                                  onTap: () {
                                    // print(apiRemote
                                    //     .readyCard.data[index].content[index]);

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewSavedVard(
                                            networkfile: imageUrl + e.thumbnail,
                                            content: apiRemote
                                                .readyCard.data[index].content,
                                            creatCardData:
                                                apiRemote.readyCard.data[index],
                                                stickerModel: widget.stickerModel
                                          ),
                                        ),
                                        (route) => true);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              imageUrl + e.cardUrl),
                                          fit: BoxFit.cover,
                                          scale: 0.8),
                                    ),
                                  ),
                                ));
                              }).toList(),
                            )
                          : Container();
                    }),

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => SaveBackGround()),
                    //         (route) => true);
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         child: Image.asset("assets/bgone.png", scale: 0.8),
                    //       ),
                    //       SizedBox(width: 7.0),
                    //       Container(
                    //           child:
                    //               Image.asset("assets/bgTwo.png", scale: 0.8))
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //         child:
                    //             Image.asset("assets/bgThree.png", scale: 0.8)),
                    //     SizedBox(width: 7.0),
                    //     Container(
                    //         child: Image.asset("assets/bgFour.png", scale: 0.8))
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //         child:
                    //             Image.asset("assets/bgFive.png", scale: 0.8)),
                    //     SizedBox(width: 7.0),
                    //     Container(
                    //         child: Image.asset("assets/bgSix.png", scale: 0.8))
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
