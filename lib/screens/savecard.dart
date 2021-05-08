import 'package:camera/camera.dart';
import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/screens/createcard.dart';
import 'package:e_invitation/screens/getsavedcard.dart';
import 'package:e_invitation/screens/selectBackGround.dart';
import 'package:e_invitation/screens/selectCard.dart';
import 'package:flutter/material.dart';
import '../utils/widget.dart' as commonDrawer;

class SavedCard extends StatefulWidget {
  int categoryid;

  SavedCard({this.categoryid});
  @override
  _SavedCardState createState() => _SavedCardState();
}

class _SavedCardState extends State<SavedCard> {
  double _height = 0.0;
  double _width = 0.0;
  var cameras;
  bool isCreatedCardSelected = false;
  bool isreadyCardSelected = false;
  bool isSavedCardSelected = false;
  ApiRemote apiRemote = ApiRemote();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String userName = "";

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getCamera();
    apiRemote.getSticker();
  }

  getCamera() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    commonDrawer.getUserName().then((value) {
      userName = value;
      setState(() {});
    });
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: commonDrawer.commonDrawer(userName, context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: _height * 0.06),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/newbg.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: _width * 0.05, right: _width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/backarrow.png")),
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
            Divider(
              color: Colors.white,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width * 0.07, top: _height * 0.03),
                child: Text(
                  'Your Activity ',
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 20,
                    color: const Color(0xffdefffd),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: _height * 0.06,
            ),
            (!this.isCreatedCardSelected)
                ? unselectedCard('Create Card', () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateCard(
                                  cameras: cameras,
                                  categoryId: widget.categoryid,
                                  stickerModel: apiRemote.stickerModel,
                                )),
                        (route) => true);
                    this.isCreatedCardSelected = true;
                    this.isreadyCardSelected = false;
                    this.isSavedCardSelected = false;
                    setState(() {});
                  })
                : selectedCard('Create Card', () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateCard(
                                cameras: cameras,
                                categoryId: widget.categoryid,
                                stickerModel: apiRemote.stickerModel)),
                        (route) => true);
                  }),
            // Container(
            //   padding: EdgeInsets.only(top: _height * 0.05),
            //   child: InkWell(
            //       onTap: () {

            //       },
            //       child: Image.asset("assets/pickCard.png")),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: _height * 0.03),
            //   child: Text(
            //     'Create Card',
            //     style: TextStyle(
            //       fontFamily: 'Helvetica Neue',
            //       fontSize: 16,
            //       color: const Color(0xffffffff),
            //       fontWeight: FontWeight.w700,
            //       // height: 4.5625,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            SizedBox(
              height: _height * 0.03,
            ),
            (!this.isreadyCardSelected)
                ? unselectedCard(
                    "Ready Card",
                    () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectCard(
                                  stickerModel: apiRemote.stickerModel)),
                          (route) => true);
                      this.isCreatedCardSelected = false;
                      this.isreadyCardSelected = true;
                      this.isSavedCardSelected = false;
                      setState(() {});
                    },
                  )
                : selectedCard(
                    "Ready Card",
                    () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectCard(
                                  stickerModel: apiRemote.stickerModel)),
                          (route) => true);
                    },
                  ),
            // Material(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0)),
            //   elevation: 10.0,
            //   color: Color(0xbdffffff),
            //   child: Material(
            //     type: MaterialType.transparency,
            //     elevation: 5.0,
            //     color: Colors.transparent,
            //     shadowColor: Colors.grey.withOpacity(0.1),
            //     child: InkWell(
            //       onTap: () {

            //       },
            //       child: Container(
            //         height: _height * 0.2,
            //         width: _width * 0.45,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               "assets/pickCard.png",
            //               color: Colors.black,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(top: 18.0),
            //               child: Text(
            //                 'Ready Card',
            //                 style: TextStyle(
            //                   fontFamily: 'Helvetica Neue',
            //                   fontSize: 16,
            //                   color: const Color(0xff3b3737),
            //                   fontWeight: FontWeight.w700,
            //                   // height: 4.5625,
            //                 ),
            //                 textAlign: TextAlign.left,
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Container(
            //   padding: EdgeInsets.only(top: _height * 0.05),
            //   child: Image.asset("assets/pickCard.png"),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: _height * 0.03),
            //   child: Text(
            //     'My Saved Card',
            //     style: TextStyle(
            //       fontFamily: 'Helvetica Neue',
            //       fontSize: 16,
            //       color: const Color(0xffffffff),
            //       fontWeight: FontWeight.w700,
            //       // height: 4.5625,
            //     ),
            //     textAlign: TextAlign.left,
            //   ),
            // ),GetSavedCard
            (!this.isSavedCardSelected)
                ? unselectedCard("Save Card", () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GetSavedCard()),
                        (route) => true);
                    this.isCreatedCardSelected = false;
                    this.isreadyCardSelected = false;
                    this.isSavedCardSelected = true;
                    setState(() {});
                  })
                : selectedCard("Save Card", () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => GetSavedCard()),
                        (route) => true);
                  })
          ],
        ),
      ),
    );
  }

  Widget selectedCard(String cardname, var callback) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10.0,
      color: Color(0xbdffffff),
      child: Material(
        type: MaterialType.transparency,
        elevation: 5.0,
        color: Colors.transparent,
        shadowColor: Colors.grey.withOpacity(0.1),
        child: InkWell(
          onTap: callback,
          child: Container(
            height: _height * 0.2,
            width: _width * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/pickCard.png",
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text(
                    '$cardname',
                    style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 16,
                      color: const Color(0xff3b3737),
                      fontWeight: FontWeight.w700,
                      // height: 4.5625,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget unselectedCard(String name, var callback) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: _height * 0.05),
          child: InkWell(
              onTap: callback, child: Image.asset("assets/pickCard.png")),
        ),
        // SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(top: _height * 0.03),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w700,
              // height: 4.5625,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
