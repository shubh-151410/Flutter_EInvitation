import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:e_invitation/Mobx/CreateCartMobx.dart/editormobx.dart';
import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/Model/readycardmodel.dart';
import 'package:e_invitation/Model/sticker_model.dart';
import 'package:e_invitation/screens/viewImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
import '../Constant/editconstant.dart' as constant;
import 'dart:ui' as ui;
import '../utils/colors.dart' as colors;

int selectedIndex;

String editText;

List<Color> listColor = [
  Color(0xffEF5354),
  Color(0xffE6425E),
  Color(0xffD82E2F),
  Color(0xff383CC1),
  Color(0xff120E43),
  Color(0xff03203C),
  Color(0xff3DBE29),
  Color(0xff66AD47),
  Color(0xffF4BE2C),
  Color(0xff758283),
  Color(0xff6A1B4D),
];

class NewSavedVard extends StatefulWidget {
  String networkfile;
  List<Content> content = List();
  StickerModel stickerModel = StickerModel();

  var creatCardData;

  NewSavedVard(
      {this.networkfile, this.creatCardData, this.content, this.stickerModel});
  @override
  _NewSavedVardState createState() => _NewSavedVardState();
}

class _NewSavedVardState extends State<NewSavedVard> {
  double _height = 0.0;
  double _width = 0.0;
  EditorState _editorState = EditorState();

  List<Map<String, dynamic>> listStickerPosition = List();

  String selectedStricker = "";

  int stickerCounter = 0;

  double _qrHeight = 60.0;

  double _qrWidth = 60.0;

  bool isQrSlider = false;

  List<String> listSticker = List<String>();

  // List<String>

  ApiRemote apiremote = ApiRemote();

  int currentTextIndex = 0;
  // int counter = 0;

  double xaxis = 0.0;

  double yAxis = 0.0;
  bool removeAllBorder = false;

  bool isOpenMenuBar = false;
  TextEditingController textEditingController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  GlobalKey _globalKey = new GlobalKey();
  Offset offset = Offset.zero;
  // GlobalKey _keyRed = GlobalKey();
  double xPosition = 0;
  double yPosition = 0;

  double xSPosition = 50;
  double ySPosition = 50;

  // List<String> listStickerAsset = [
  //   "assets/stickers/sticker.png",
  //   "assets/stickers/sticker2.png",
  //   "assets/stickers/sticker3.png",
  //   "assets/stickers/sticker4.png",
  //   "assets/stickers/sticker5.png"
  // ];
  String savefilepath;

  @override
  void initState() {
    listStickerPosition.add({
      constant.xPositionSticker: 50.0,
      constant.yPositionSticker: 50.0,
    });
    super.initState();
    widget.content.forEach((element) {
      _editorState.textCard.insert(currentTextIndex, element.text);
      _editorState.listTextStyle.insert(currentTextIndex, {
        constant.FontFamily: element.fontFamily,
        constant.COLOR: Color(int.tryParse('0xff${element.color}')),
        constant.FONTSIZE: double.tryParse(element.size),
        constant.FONTWEIGHT:
            (element.fontStyle == "bold") ? FontWeight.bold : FontWeight.normal,
        constant.xPostion: double.tryParse(element.x) ,
        constant.yPosition: (double.tryParse(element.y)),
        constant.DECORATION: TextDecoration.none,
        constant.FONTSTYLE: (element.fontStyle == "normal")?FontStyle.normal:FontStyle.italic,
        constant.OPACITY: 1.0,
        constant.BLUR: 0.0,
      });
      // _editorState.textCard.add();
    });
    currentTextIndex++;

    _editorState.listTextStyle = _editorState.listTextStyle;
  }

  @override
  void dispose() {
    selectedIndex = null;
    super.dispose();
  }

  void showSnackBar() {
    final snackBarContent = SnackBar(
      content: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Please Wait"),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  _capturePng() async {
    try {
      _editorState.currentIndexText = null;
      this.removeAllBorder = true;
      setState(() {});

      showSnackBar();
      Future.delayed(Duration(seconds: 1), () async {
        RenderRepaintBoundary boundary =
            _globalKey.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage(pixelRatio: 5.0);
        ByteData byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData.buffer.asUint8List();
        // var bs64 = base64Encode(pngBytes);

        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File("$dir/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            ".png");
        await file.writeAsBytes(pngBytes);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewImage(
              filedata: file.path,
              content: _editorState.listTextStyle,
              createCardPath: file.path,
              userType: "",
              categoryId: widget.creatCardData.categoryId,
              bgImageUrl: widget.networkfile,
              qrCode: (apiremote.qrCodeModel.data != null)
                  ? apiremote.qrCodeModel.data.first.qrcode
                  : "",
            ),
          ),
        );
        _scaffoldkey.currentState.hideCurrentSnackBar();

        // return pngBytes;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: colors.mainbgColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors.mainbgColor,
        type: BottomNavigationBarType.fixed, // This is all you need!

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/textIcon.png")),
            label: 'Text',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/stickerIcon2.png")),
            label: 'Sticker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Code',
          ),
        ],
        // currentIndex: _editorState.selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xffb7fffa),

        onTap: (int index) async {
          _editorState.selectedIndex = index;

          _editorState.isMenuOPen = false;
          // selectedIndex = null;
          editText = null;
          setState(() {});
          // setState(() {

          // });

          if (index == 2) {
            showSnackBar();

            await apiremote.getQrCode(widget.creatCardData.categoryId);
            xPosition = MediaQuery.of(context).size.height / 3;
            yPosition = MediaQuery.of(context).size.width / 2;
            setState(() {});

            _scaffoldkey.currentState.hideCurrentSnackBar();
          }
        },
      ),
      body: Container(
        height: _height,
        width: _width,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: _width * 0.05,
                      right: _width * 0.05,
                      top: _height * 0.06),
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
                            // this.removeAllBorder = true;
                            // setState(() {});
                            (this._editorState.isMenuOPen)
                                ? this._editorState.isMenuOPen = false
                                : this._editorState.isMenuOPen = true;
                          },
                          child: Image.asset("assets/drawericon.png"))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: _width * 0.05, right: _width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invitaition Card',
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 20,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Download',
                            style: TextStyle(
                              fontFamily: 'Helvetica Neue',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),

                          IconButton(
                            icon: ImageIcon(
                              AssetImage("assets/downloadIcon.png"),
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // this.removeAllBorder = true;
                              // setState(() {});
                              _capturePng();
                            },
                            // onPressed: _capturePng,
                          )
                          // Image.asset("assets/downloadIcon.png")
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                            child: Image.network(
                          widget.networkfile,
                          // key: _keyRed,
                          fit: BoxFit.contain,
                        )),
                        Observer(builder: (context) {
                          return Stack(
                              children: _editorState.textCard.map((e) {
                            int i = _editorState.textCard.indexOf(e);
                            return Align(
                              alignment: Alignment(
                                  _editorState.listTextStyle[i]
                                      [constant.xPostion],
                                  _editorState.listTextStyle[i]
                                      [constant.yPosition]),
                              // alignment: Alignment(
                              //     _editorState.listTextStyle[i]
                              //         [constant.xPostion],
                              //     _editorState.listTextStyle[i]
                              //         [constant.yPosition]),
                              child: GestureDetector(
                                onTap: () {
                                  _editorState.isMenuOPen = true;
                                  _editorState.currentIndexText = i;
                                  selectedIndex = i;
                                  setState(() {});
                                },
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 10.0),
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 10.0,
                                      right: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: (this.removeAllBorder)
                                            ? Colors.transparent
                                            : (_editorState.currentIndexText ==
                                                    i)
                                                ? Colors.black
                                                : Colors.transparent,
                                        width: 3.0),
                                  ),
                                  child: Opacity(
                                    opacity: _editorState.listTextStyle[i]
                                        [constant.OPACITY],
                                    child: Text(
                                      _editorState.textCard[i],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              blurRadius:
                                                  _editorState.listTextStyle[i]
                                                      [constant.BLUR],
                                              // color: Colors.blue,
                                              offset: Offset(0.0, 0.0),
                                            ),
                                          ],
                                          fontFamily:
                                              _editorState.listTextStyle[i]
                                                  [constant.FontFamily],
                                          decoration:
                                              _editorState.listTextStyle[i]
                                                  [constant.DECORATION],
                                          color: _editorState.listTextStyle[i]
                                              ['color'],
                                          fontStyle: _editorState
                                              .listTextStyle[i]['fontStyle'],
                                          fontSize: _editorState
                                              .listTextStyle[i]['fontSize'],
                                          fontWeight: _editorState
                                              .listTextStyle[i]['fontWeight']),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList());
                        }),
                        (apiremote.qrCodeModel.data != null)
                            ? Positioned(
                                top: yPosition,
                                left: xPosition,
                                child: GestureDetector(
                                  onPanUpdate: (tapInfo) {
                                    setState(() {
                                      xPosition += tapInfo.delta.dx;
                                      yPosition += tapInfo.delta.dy;
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      this.isQrSlider = true;
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      this.isQrSlider = false;
                                    });
                                  },
                                  child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: _qrHeight,
                                      width: _qrWidth,
                                      child: Image.network(
                                          "${apiremote.qrCodeModel.data.first.qrcode}")),
                                ),
                              )
                            : Container(),
                        Stack(
                            children: listSticker.asMap().entries.map((e) {
                          // print(e.key);
                          return Positioned(
                            top: listStickerPosition[e.key]
                                    [constant.yPositionSticker] +
                                e.key * 40,
                            left: listStickerPosition[e.key]
                                    [constant.xPositionSticker] +
                                e.key * 40,
                            child: GestureDetector(
                              onPanUpdate: (tapInfo) {
                                setState(() {
                                  listStickerPosition[e.key]
                                          [constant.xPositionSticker] +=
                                      tapInfo.delta.dx;
                                  listStickerPosition[e.key]
                                          [constant.yPositionSticker] +=
                                      tapInfo.delta.dy;
                                });
                              },
                              child: Image.network(e.value),
                            ),
                          );
                        }).toList()),
                        (selectedStricker.isNotEmpty)
                            ? Positioned(
                                top: ySPosition,
                                left: xSPosition,
                                child: GestureDetector(
                                  onPanUpdate: (tapInfo) {
                                    setState(() {
                                      xSPosition += tapInfo.delta.dx;
                                      ySPosition += tapInfo.delta.dy;
                                    });
                                  },
                                  child: Image.asset(
                                    selectedStricker,
                                    // scale: 3.0,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
             if (this.isQrSlider)
              Positioned(
                  bottom: 0.0,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    color: colors.mainbgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          alignment: Alignment.center,
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              value: _qrHeight,
                              min: 0.0,
                              max: 200.0,
                              activeColor: Color(0xff64FFF4),
                              inactiveColor: Color(0xffAAFFF9),
                              divisions: 5,
                              // label: _currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _qrWidth = value;
                                  _qrHeight = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            // if (selectedIndex != null)
            Observer(builder: (context) {
              return (_editorState.selectedIndex == 0)
                  ? TextFieldDialog(
                      addEvent: (date) {
                        _editorState.textCard.insert(currentTextIndex, date);

                        _editorState.textCard = _editorState.textCard;
                        _editorState.listTextStyle.insert(currentTextIndex, {
                          constant.FontFamily: 'OpenSans',
                          constant.COLOR: Colors.white,
                          constant.FONTSTYLE: FontStyle.normal,
                          constant.FONTSIZE: 22.0,
                          constant.FONTWEIGHT: FontWeight.normal,
                          constant.DECORATION: TextDecoration.none,
                          constant.xPostion: 0.0,
                          constant.yPosition: 0.0,
                          constant.OPACITY: 1.0,
                          constant.BLUR: 0.0,
                        });

                        _editorState.listTextStyle = _editorState.listTextStyle;
                        currentTextIndex++;

                        _editorState.selectedIndex = null;
                      },
                      cancealEvent: () {
                        _editorState.selectedIndex = null;
                        // this.isText = false;
                      },
                    )
                  : (_editorState.selectedIndex == 1)
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            color: colors.mainAlertDialogbgColor,
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 20),
                            child: Wrap(
                              spacing: 40.0,
                              children: widget.stickerModel.data.map((e) {
                                int index = widget.stickerModel.data.indexOf(e);
                                return InkWell(
                                    onTap: () {
                                      listSticker.add(
                                          "http://pearl.tradeguruweb.com/${e.stickerUrl}");
                                      listStickerPosition.add({
                                        constant.xPositionSticker: 50.0,
                                        constant.yPositionSticker: 50.0,
                                      });

                                      print(listSticker);
                                      setState(() {});
                                    },
                                    child: Image.network(
                                        "http://pearl.tradeguruweb.com/${e.stickerUrl}"));
                              }).toList(),
                            ),
                          ),
                        )
                      : Container();
            }),
            if (selectedIndex != null) editorMenu(),

            // if (_editorState.selectedIndex == 2) SelectImageDialog()
          ],
        ),
      ),
    );
  }

  // ------------------ Editor Menu Open ---------------- //////////
  Widget editorMenu() {
    return Observer(builder: (context) {
      return (_editorState.isMenuOPen)
          ? Positioned(
              bottom: 0,
              width: _width,
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Color(0xffaafff9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              this._editorState.isControls = true;
                              this._editorState.isFonts = false;
                              this._editorState.isColor = false;
                              this._editorState.isOpacity = false;
                            },
                            child: Text(
                              'Controls',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 12,
                                color: (this._editorState.isControls)
                                    ? Color(0xff000000)
                                    : Color(0xd5548884),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _editorState.isControls = false;
                              _editorState.isFonts = true;
                              _editorState.isColor = false;
                              _editorState.isOpacity = false;
                            },
                            child: Text(
                              'Fonts ',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 12,
                                color: (_editorState.isFonts)
                                    ? Colors.black
                                    : Color(0xd5548884),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _editorState.isControls = false;
                              _editorState.isFonts = false;
                              _editorState.isColor = true;
                              _editorState.isOpacity = false;
                            },
                            child: Text(
                              'Color ',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 12,
                                color: (_editorState.isColor)
                                    ? Colors.black
                                    : Color(0xd5548884),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _editorState.isControls = false;
                              _editorState.isFonts = false;
                              _editorState.isColor = false;
                              _editorState.isOpacity = true;
                            },
                            child: Text(
                              'Opacity & Shadow  ',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 12,
                                color: (_editorState.isOpacity)
                                    ? Colors.black
                                    : Color(0xd5548884),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: colors.mainbgColor,
                        child: Observer(builder: (
                          context,
                        ) {
                          return (_editorState.isControls)
                              ? ControlsText(
                                  maplistStyle:
                                      _editorState.listTextStyle[selectedIndex],
                                  onChanged: (data) {
                                    if (data == "isedit") {
                                      editText =
                                          _editorState.textCard[selectedIndex];

                                      _editorState.isMenuOPen = false;

                                      // selectedIndex = null;
                                      _editorState.selectedIndex = 0;
                                      setState(() {});
                                    } else {
                                      _editorState.listTextStyle
                                          .removeAt(selectedIndex);
                                      _editorState.listTextStyle
                                          .insert(selectedIndex, data);

                                      _editorState.listTextStyle =
                                          _editorState.listTextStyle;
                                    }
                                  })
                              : (_editorState.isFonts)
                                  ? Fonts(
                                      maplistStyle: _editorState
                                          .listTextStyle[selectedIndex],
                                      onChanged: (data) {
                                        _editorState.listTextStyle
                                            .removeAt(selectedIndex);
                                        _editorState.listTextStyle
                                            .insert(selectedIndex, data);

                                        _editorState.listTextStyle =
                                            _editorState.listTextStyle;
                                      })
                                  : (_editorState.isColor)
                                      ? ColorSetting(
                                          maplistStyle: _editorState
                                              .listTextStyle[selectedIndex],
                                          onChanged: (data) {
                                            _editorState.listTextStyle
                                                .removeAt(selectedIndex);
                                            _editorState.listTextStyle
                                                .insert(selectedIndex, data);

                                            _editorState.listTextStyle =
                                                _editorState.listTextStyle;
                                          })
                                      : (_editorState.isOpacity)
                                          ? OpacityAndShadows(
                                              maplistStyle: _editorState
                                                  .listTextStyle[selectedIndex],
                                              onChanged: (data) {
                                                _editorState.listTextStyle
                                                    .removeAt(selectedIndex);
                                                _editorState.listTextStyle
                                                    .insert(
                                                        selectedIndex, data);

                                                _editorState.listTextStyle =
                                                    _editorState.listTextStyle;
                                              })
                                          : Container();
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container();
    });
  }
}

class TextFieldDialog extends StatelessWidget {
  double _height = 0.0;
  double _width = 0.0;

  var cancealEvent;
  var addEvent;
  TextFieldDialog({
    this.cancealEvent,
    this.addEvent,
  });
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    TextEditingController textEditingController = TextEditingController();
    if (editText != null) {
      textEditingController = TextEditingController(text: editText);
    }
    return Container(
      height: _height,
      padding: EdgeInsets.only(bottom: _height * 0.15),
      color: colors.mainAlertDialogbgColor.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 238.0,
            width: _width,
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffaafff9),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x363b3737),
                  offset: Offset(0, -13),
                  blurRadius: 22,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 60.0,
                  width: _width,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 109.0,
                    child: Text(
                      'Add Text',
                      style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    color: const Color(0xff58ccc1),
                  ),
                ),
                Container(
                  width: _width,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    maxLines: 5,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type here",
                      hintStyle: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 16,
                        color: const Color(0xff3b3737),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonTheme(
                        minWidth: 135.0,
                        height: 41.0,
                        buttonColor: const Color(0xff85cfca),
                        child: RaisedButton(
                          onPressed: cancealEvent,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Helvetica Neue',
                              fontSize: 16,
                              color: const Color(0xff3b3737),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 135.0,
                        height: 40.0,
                        buttonColor: const Color(0xff58ccc1),
                        child: RaisedButton(
                          onPressed: () {
                            addEvent(textEditingController.text);
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Helvetica Neue',
                              fontSize: 16,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              // height: 1.6875,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ControlsText extends StatelessWidget {
  var maplistStyle;

  var onChanged;
  ControlsText({this.onChanged, this.maplistStyle});
  @override
  Widget build(BuildContext context) {
    double localyCordinate;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: colors.settingBoxColor,
              padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            var abc;

                            localyCordinate = maplistStyle[constant.yPosition];

                            if (localyCordinate == 0.0) {
                              abc = (localyCordinate + 0.15);
                              maplistStyle[constant.yPosition] = -abc;
                            } else {
                              abc = (localyCordinate - 0.15);
                              maplistStyle[constant.yPosition] = abc;
                            }

                            onChanged(maplistStyle);
                          },
                          child: directionButton(
                              "assets/controls/upwardarrow.png")),
                      InkWell(
                          onTap: () {
                            var abc;

                            localyCordinate = maplistStyle[constant.xPostion];

                            if (localyCordinate == 0.0) {
                              abc = (localyCordinate + 0.15);
                              maplistStyle[constant.xPostion] = -abc;
                            } else {
                              abc = (localyCordinate - 0.15);
                              maplistStyle[constant.xPostion] = abc;
                            }

                            //  var abc = (localyCordinate-0.15);

                            // maplistStyle[constant.ALIGNMENT] =
                            //     Alignment(0.0, -0.2);
                            onChanged(maplistStyle);
                          },
                          child:
                              directionButton("assets/controls/leftarrow.png")),
                      InkWell(
                          onTap: () {
                            onChanged("isedit");
                          },
                          child:
                              EditButton("assets/controls/pencil.png", "Edit")),
                      ALignButtom()
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          var abc;

                          localyCordinate = maplistStyle[constant.yPosition];

                          abc = (localyCordinate + 0.15);
                          maplistStyle[constant.yPosition] = abc;

                          onChanged(maplistStyle);
                        },
                        child:
                            directionButton("assets/controls/downardarrow.png"),
                      ),
                      InkWell(
                        onTap: () {
                          var abc;

                          localyCordinate = maplistStyle[constant.xPostion];

                          abc = (localyCordinate + 0.15);
                          maplistStyle[constant.xPostion] = abc;

                          onChanged(maplistStyle);
                        },
                        child: directionButton("assets/controls/image.png"),
                      ),
                      EditButton("assets/controls/copy.png", "Copy"),
                      FontSetting()
                    ],
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget directionButton(String imagepath) {
    return Container(
      height: 40,
      width: 40,
      child: Image.asset(imagepath),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xff64fff4),
      ),
    );
  }

  Widget EditButton(String imagePath, String name) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xff64fff4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 12,
              color: const Color(0xff548884),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }

  Widget ALignButtom() {
    return Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xff64fff4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                maplistStyle[constant.xPostion] = -1.0;
                onChanged(maplistStyle);
              },
              child: Image.asset("assets/controls/leftAlign.png")),
          InkWell(
              onTap: () {
                maplistStyle[constant.xPostion] = 0.0;
                onChanged(maplistStyle);
              },
              child: Image.asset("assets/controls/center.png")),
          InkWell(
              onTap: () {
                maplistStyle[constant.xPostion] = 1.0;
                onChanged(maplistStyle);
              },
              child: Image.asset("assets/controls/rightAlign.png")),
        ],
      ),
    );
  }

  Widget FontSetting() {
    return Container(
      height: 40,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: const Color(0xff64fff4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 22,
              width: 22,
              child: Image.asset(
                "assets/controls/letter.png",
                fit: BoxFit.cover,
              )),
          InkWell(
            onTap: () {
              if (this.maplistStyle[constant.FONTWEIGHT] == FontWeight.normal) {
                this.maplistStyle[constant.FONTWEIGHT] = FontWeight.bold;
              } else {
                this.maplistStyle[constant.FONTWEIGHT] = FontWeight.normal;
              }
              this.onChanged(maplistStyle);
            },
            child: Container(
                height: 22,
                width: 22,
                child: Image.asset(
                  "assets/controls/bold.png",
                  fit: BoxFit.cover,
                )),
          ),
          InkWell(
            onTap: () {
              if (this.maplistStyle[constant.DECORATION] ==
                  TextDecoration.none) {
                this.maplistStyle[constant.DECORATION] =
                    TextDecoration.underline;
              } else {
                this.maplistStyle[constant.DECORATION] = TextDecoration.none;
              }
              this.onChanged(maplistStyle);
            },
            child: Container(
                height: 22,
                width: 22,
                child: Image.asset(
                  "assets/controls/underline.png",
                  fit: BoxFit.cover,
                )),
          ),
          InkWell(
            onTap: () {
              if (this.maplistStyle[constant.FONTSTYLE] == FontStyle.italic) {
                this.maplistStyle[constant.FONTSTYLE] = FontStyle.normal;
              } else {
                this.maplistStyle[constant.FONTSTYLE] = FontStyle.italic;
              }
              this.onChanged(maplistStyle);
            },
            child: Container(
                height: 22,
                width: 22,
                child: Image.asset(
                  "assets/controls/italic.png",
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );
  }
}

class Fonts extends StatelessWidget {
  var maplistStyle;

  var onChanged;

  Fonts({this.maplistStyle, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: colors.settingBoxColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      maplistStyle[constant.FontFamily] = 'OpenSans';
                      onChanged(maplistStyle);
                    },
                    child: Text(
                      'Tap to select font',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 19,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      maplistStyle[constant.FontFamily] = 'DancingScript';
                      onChanged(maplistStyle);
                    },
                    child: Text(
                      'Tap to select font',
                      style: TextStyle(
                        fontFamily: 'DancingScript',
                        fontSize: 12,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      maplistStyle[constant.FontFamily] = 'Nunito';
                      onChanged(maplistStyle);
                    },
                    child: Text(
                      'Tap to select font',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      maplistStyle[constant.FontFamily] = 'HachiMaruPop';
                      onChanged(maplistStyle);
                    },
                    child: Text(
                      'Tap to select font',
                      style: TextStyle(
                        fontFamily: 'HachiMaruPop',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      maplistStyle[constant.FontFamily] = 'PottaOne';
                      onChanged(maplistStyle);
                    },
                    child: Text(
                      'Tap to select font',
                      style: TextStyle(
                        fontFamily: 'PottaOne',
                        fontSize: 19,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class ColorSetting extends StatelessWidget {
  var maplistStyle;

  var onChanged;

  ColorSetting({this.maplistStyle, this.onChanged});
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listColor.map((e) {
            return InkWell(
              onTap: () {
                maplistStyle[constant.COLOR] = e;
                onChanged(maplistStyle);
              },
              child: Container(
                height: 50,
                width: 30,
                color: e,
              ),
            );
          }).toList(),
        )
        // Expanded(
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     color: colors.settingBoxColor,
        //     child: Text("Controls"),
        //   ),
        // ),
      ],
    );
  }
}

class OpacityAndShadows extends StatelessWidget {
  var maplistStyle;

  var onChanged;
  OpacityAndShadows({this.maplistStyle, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: colors.settingBoxColor,
            padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opacity',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 15,
                        color: const Color(0xffaafff9),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 110,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: maplistStyle[constant.OPACITY],
                          min: 0.0,
                          max: 1.0,
                          activeColor: Color(0xff64FFF4),
                          inactiveColor: Color(0xffAAFFF9),
                          divisions: 5,
                          // label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            maplistStyle[constant.OPACITY] = value;
                            onChanged(maplistStyle);
                          },
                        ),
                      ),
                    ),
                    Text(
                      'Blur',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 15,
                        color: const Color(0xffaafff9),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 110,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          value: maplistStyle[constant.BLUR],
                          min: 0,
                          max: 30,
                          activeColor: Color(0xff64FFF4),
                          inactiveColor: Color(0xffAAFFF9),
                          divisions: 5,
                          // label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            maplistStyle[constant.BLUR] = value;
                            onChanged(maplistStyle);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'FontSize',
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 15,
                          color: const Color(0xffaafff9),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 110,
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              value: maplistStyle[constant.FONTSIZE],
                              min: 0,
                              max: 40,
                              activeColor: Color(0xff64FFF4),
                              inactiveColor: Color(0xffAAFFF9),
                              divisions: 5,
                              // label: _currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                maplistStyle[constant.FONTSIZE] = value;
                                onChanged(maplistStyle);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   'Color',
                    //   style: TextStyle(
                    //     fontFamily: 'Helvetica Neue',
                    //     fontSize: 12,
                    //     color: const Color(0xffaafff9),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //   textAlign: TextAlign.left,
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight * 2;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
