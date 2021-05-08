import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/Model/categoryModel.dart';
import 'package:e_invitation/screens/about_me.dart';
import 'package:e_invitation/screens/login.dart';
import 'package:e_invitation/screens/privacy_policy.dart';
import 'package:e_invitation/screens/profile_screen.dart';
import 'package:e_invitation/screens/savecard.dart';
import 'package:e_invitation/screens/signup.dart';
import 'package:e_invitation/screens/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart' as colors;
import '../utils/widget.dart' as commonDrawer;

class SelectCardType extends StatefulWidget {
  @override
  _SelectCardTypeState createState() => _SelectCardTypeState();
}

class _SelectCardTypeState extends State<SelectCardType> {
  double _height = 0.0;
  double _width = 0.0;
  ApiRemote apiRemote = ApiRemote();

  String userName = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Data> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiRemote.getCateoryCard();

    // getUserName();
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
      backgroundColor: colors.mainbgColor,
      drawer: commonDrawer.commonDrawer(userName, context),
      body: Container(
        margin: EdgeInsets.only(top: _height * 0.06),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: _width * 0.05, right: _width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Image.asset("assets/backarrow.png")),
                  Expanded(
                    child: Column(
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(right: _width * 0.03),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Other Categories ',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 12,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 0.8333333333333334,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // SizedBox(width: 18.0),
                        // Image.asset("assets/filtericon.png")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.05, right: _width * 0.01),
                    child: CustomTextField(
                      height: _height,
                      width: _width,
                      hintname: "SEARCH",
                      isObscureText: false,
                      iconpath: "assets/searchicon.png",
                      callback: (data) {
                        // print(data);
                        // List<Data> localChanel = List();
                        // localChannel.addAll(_allApi.allchannel);
                        if (data.isEmpty) {
                          _searchResult.clear();
                          setState(() {});
                          // addFeed.issearchedactive = false;
                          // addFeed.searchedChannel.clear();
                          // apiRemote.searchCategory.data.clear();
                          // apiRemote.searchCategory.data =
                          //     apiRemote.searchCategory.data;
                        } else {
                          // print("ASDASDASDASDASDASDASDASD");

                          apiRemote.allCategory.data.forEach(
                            (element) {
                              if (element.name
                                  .toLowerCase()
                                  .contains(data.toLowerCase())) {
                                _searchResult.clear();
                                _searchResult.add(element);
                                // localChanel.add(element);
                              } else {
                                //        _searchResult.clear();
                                // setState(() {});

                              }
                            },
                          );
                          setState(() {}); // print(loca)
                          // apiRemote.searchCategory.data.clear();

                          // apiRemote.searchCategory.data.addAll(localChanel);
                          print(apiRemote.searchCategory.data);
                          // apiRemote.searchCategory.data =
                          //     apiRemote.searchCategory.data;

                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.05, right: _width * 0.02),
                    child: Text(
                      'Select card type',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Observer(builder: (context) {
                    return _searchResult.length != 0
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _searchResult.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = _searchResult[index];
                              return CustomCard(
                                width: _width,
                                height: _height,
                                iconPath: data.imgUrl,
                                templateName: data.name,
                                categoryId: data.id,
                              );
                            },
                          )
                        : (apiRemote.allCategory.data != null)
                            ? ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = apiRemote.allCategory.data[index];
                                  return CustomCard(
                                    width: _width,
                                    height: _height,
                                    iconPath: data.imgUrl,
                                    templateName: data.name,
                                    categoryId: data.id,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: apiRemote.allCategory.data.length)
                            : Container();
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  double width = 0.0;
  double height = 0.0;
  String iconPath = "";
  String imageUrl = "http://pearl.tradeguruweb.com/";
  String templateName = "";
  int categoryId;
  CustomCard(
      {this.height,
      this.width,
      this.iconPath,
      this.templateName,
      this.categoryId});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.02),
      child: InkWell(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SavedCard(
                        categoryid: categoryId,
                      )),
              (route) => true);
        },
        child: Stack(
          children: [
            Container(
              height: 200,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("$imageUrl$iconPath"),
                      fit: BoxFit.fill)),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [const Color(0x003b3737), const Color(0xc2000000)],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Positioned(
              height: 230,
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 15, left: 20),
                  child: Text(
                    '$templateName',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                      // height: 0.625,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// InkWell(
//   onTap: () {

//   },
//   child: CustomCard(
//     width: _width,
//     height: _height,
//     iconPath: "assets/demoone.png",
//   ),
// ),
// SizedBox(
//   height: 30,
// ),
// Padding(
//   padding: EdgeInsets.only(
//       left: _width * 0.05, right: _width * 0.02),
//   child: Stack(
//     children: [
//       Container(
//         height: 230,
//         width: 530,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/demotwo.png"),
//                 fit: BoxFit.cover)),
//       ),
//       Container(
//         height: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           gradient: LinearGradient(
//             begin: Alignment(0.0, -1.0),
//             end: Alignment(0.0, 1.0),
//             colors: [
//               const Color(0x003b3737),
//               const Color(0xc2000000)
//             ],
//             stops: [0.0, 1.0],
//           ),
//         ),
//       ),
//       Positioned(
//         height: 230,
//         bottom: 30,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             padding: EdgeInsets.only(bottom: 15, left: 20),
//             child: Text(
//               'Birthday Templates',
//               style: TextStyle(
//                 fontFamily: 'Helvetica',
//                 fontSize: 16,
//                 color: const Color(0xffffffff),
//                 fontWeight: FontWeight.w700,
//                 // height: 0.625,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// Padding(
//   padding: EdgeInsets.only(
//       left: _width * 0.05, right: _width * 0.02),
//   child: Stack(
//     children: [
//       Container(
//         height: 230,
//         width: 530,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/demothree.png"),
//                 fit: BoxFit.cover)),
//       ),
//       Container(
//         height: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           gradient: LinearGradient(
//             begin: Alignment(0.0, -1.0),
//             end: Alignment(0.0, 1.0),
//             colors: [
//               const Color(0x003b3737),
//               const Color(0xc2000000)
//             ],
//             stops: [0.0, 1.0],
//           ),
//         ),
//       ),
//       Positioned(
//         height: 230,
//         bottom: 30,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             padding: EdgeInsets.only(bottom: 15, left: 20),
//             child: Text(
//               'Confrence Templates',
//               style: TextStyle(
//                 fontFamily: 'Helvetica',
//                 fontSize: 16,
//                 color: const Color(0xffffffff),
//                 fontWeight: FontWeight.w700,
//                 // height: 0.625,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
