import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/screens/selectCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../utils/colors.dart' as colors;

class SelectBackGround extends StatefulWidget {
  @override
  _SelectBackGroundState createState() => _SelectBackGroundState();
}

class _SelectBackGroundState extends State<SelectBackGround> {
  double _height = 0.0;
  double _width = 0.0;
  String imageUrl = "http://pearl.tradeguruweb.com/";

  ApiRemote apiRemote = ApiRemote();

  @override
  void initState() {
    apiRemote.getReadyCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.mainbgColor,
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(top: _height * 0.06, bottom: _height * 0.02),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: _width * 0.05,
                    right: _width * 0.05,
                  ),
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
                      Image.asset("assets/drawericon.png")
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: _width * 0.05,
                    ),
                    child: Text(
                      'Select background',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: _height * 0.05),
                // GridView.builder(gridDelegate: null, itemBuilder: null)
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 8.0, right: 8.0),
                //     child: Observer(builder: (context) {
                //       return (apiRemote.readyCard.status != null)
                //           ? GridView.count(
                //               crossAxisCount: 3,
                //               // childAspectRatio: 9 / 8,
                //               padding: const EdgeInsets.all(0.0),
                //               crossAxisSpacing: 8.0,
                //               mainAxisSpacing: 8.0,
                //               shrinkWrap: true,
                //               children: apiRemote.readyCard.data
                //                   .map((e) => GridTile(
                //                         child: InkWell(
                //                           onTap: () {
                //                             Navigator.pushAndRemoveUntil(
                //                                 context,
                //                                 MaterialPageRoute(
                //                                     builder: (context) =>
                //                                         SelectCard()),
                //                                 (route) => true);
                //                           },
                //                           child: Container(
                //                             height: _width * 0.0,
                //                             width: _width * 0.0,
                //                             decoration: BoxDecoration(
                //                               border: Border.all(
                //                                   color: Colors.black),
                //                               borderRadius: BorderRadius.all(
                //                                 Radius.circular(20.0),
                //                               ),
                //                               image: DecorationImage(
                //                                   image: NetworkImage(
                //                                       imageUrl + e.cardUrl),
                //                                   fit: BoxFit.cover),
                //                             ),
                //                           ),
                //                         ),
                //                       ))
                //                   .toList(),
                //             )
                //           : Container();
                //     }),
                //   ),
                // ),
                // Wrap(
                //   direction: Axis.horizontal,
                //   runAlignment: WrapAlignment.spaceBetween,
                //   children: imageName.map((e) {
                //     return InkWell(
                //       onTap: () {
                //

                //       },
                //       child: Container(
                //         width: 130,
                //         height: 130,
                //         margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black),
                //           borderRadius: BorderRadius.circular(10.0),
                //           image: DecorationImage(
                //               image: AssetImage(e), fit: BoxFit.fitWidth),
                //         ),
                //       ),
                //     );
                //   }).toList(),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
