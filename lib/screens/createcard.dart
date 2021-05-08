import 'dart:io';
import 'dart:typed_data';

import 'package:e_invitation/Mobx/apiremote.dart';
import 'package:e_invitation/Model/sticker_model.dart';
import 'package:e_invitation/screens/CreateCard/localcamera.dart';
import 'package:e_invitation/screens/savedCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import '../utils/colors.dart' as colors;
import '../utils/widget.dart' as commonDrawer;


class CreateCard extends StatefulWidget {
  var cameras;
  int categoryId;
  String userType;
  StickerModel stickerModel = StickerModel();
  CreateCard({this.cameras, this.categoryId,this.stickerModel,this.userType});
  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  double _height = 0.0;
  double _width = 0.0;
  int _selectedIndex = 0;

  String categoryId = "";

  
  String imageUrl = "http://pearl.tradeguruweb.com/";

   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ApiRemote apiRemote = ApiRemote();

  String userName = "";

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

  @override
  void initState() {
    // _fetchAssets();
    apiRemote.getBackGround(widget.categoryId);

    super.initState();
  }

  List<AssetEntity> assets = [];

  _fetchAssets() async {
    final permitted = await PhotoManager.requestPermission();

    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 1000000,
    );

    setState(() => assets = recentAssets);
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
       drawer: commonDrawer.commonDrawer(userName, context),
      backgroundColor: colors.mainbgColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colors.mainbgColor,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Helvetica Neue',
          fontSize: 12,
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Helvetica Neue',
          fontSize: 12,
          color: const Color(0xffffffff),
          fontWeight: FontWeight.w500,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/pickCard.png"),
              color: Colors.white,
            ),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/cameraicon.png"),
              color: Colors.white,
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/stickericon.png"),
              color: Colors.white,
            ),
            label: 'Color',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        elevation: 0.0,
        onTap: (value) {
          switch (value) {
            case 0:
              ImagePicker.platform
                  .pickImage(source: ImageSource.gallery)
                  .then((value) async {
                if (value != null) {
                  await ImageCropper.cropImage(sourcePath: value.path)
                      .then((value) {
                    if (value != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SaveBackGround(localfile: value.path,categoryId: categoryId,stickerModel: widget.stickerModel,userType: widget.userType??"",)),
                          (route) => true);
                    }
                  });
                }
              });

              break;
            case 1:
              ImagePicker.platform
                  .pickImage(source: ImageSource.camera)
                  .then((value) async {
                if (value != null) {
                  await ImageCropper.cropImage(sourcePath: value.path)
                      .then((value) {
                    if (value != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SaveBackGround(localfile: value.path,categoryId: categoryId,stickerModel: widget.stickerModel,userType: widget.userType??"")),
                          (route) => true);
                    }
                  });
                }
              });
              break;
            case 2:
              _selectedIndex = value;
              setState(() {});
              break;

            default:
          }
        },
      ),
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(top: _height * 0.06, bottom: _height * 0.02),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: _width * 0.05,
                right: _width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: ImageIcon(
                      AssetImage("assets/backarrow.png"),
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Image.asset("assets/backarrow.png"),
                  // ),
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
                    onTap: (){
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
            SizedBox(
              height: 15,
            ),
            (_selectedIndex == 0 || _selectedIndex == 1)
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Observer(builder: (context) {
                        return (apiRemote.backgroundCard.status != null)
                            ? GridView.count(
                                crossAxisCount: 3,
                                // childAspectRatio: 9 / 8,
                                padding: const EdgeInsets.all(0.0),
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                shrinkWrap: true,
                                children:
                                    apiRemote.backgroundCard.data.map((e) {
                                  int index =
                                      apiRemote.backgroundCard.data.indexOf(e);
                                  categoryId = apiRemote
                                                    .backgroundCard.data[index].categoryId;
                                  
                                  return GridTile(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SaveBackGround(
                                                creatCardData: apiRemote
                                                    .backgroundCard.data[index],
                                                networkfile:
                                                    imageUrl + e.backgroundUrl,
                                                stickerModel: widget.stickerModel,
                                                userType: widget.userType??""
                                               
                                               
                                                
                                              ),
                                            ),
                                            (route) => true);
                                      },
                                      child: Container(
                                        height: _width * 0.0,
                                        width: _width * 0.0,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  imageUrl + e.backgroundUrl),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            : Container();
                      }),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GridView.count(
                        crossAxisCount: 3,
                        // childAspectRatio: 9 / 8,
                        padding: const EdgeInsets.all(0.0),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        shrinkWrap: true,
                        children: listColor
                            .map((e) => GridTile(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SaveBackGround(
                                                    color: e,
                                                    categoryId: categoryId,stickerModel: widget.stickerModel,
                                                    userType: widget.userType??""
                                                  )),
                                          (route) => true);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: e,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<AssetEntity> assets = [];

  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 1000000,
    );

    setState(() => assets = recentAssets);
  }

  @override
  void initState() {
    _fetchAssets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: assets.length,
        itemBuilder: (_, index) {
          return AssetThumbnail(asset: assets[index]);
        },
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key key,
    @required this.asset,
  }) : super(key: key);

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;

        if (bytes == null) return CircularProgressIndicator();

        return InkWell(
          onTap: () {
            if (asset.type == AssetType.image) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImageScreen(imageFile: asset.file),
                ),
              );
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.memory(bytes, fit: BoxFit.cover),
              ),
              if (asset.type == AssetType.video)
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key key,
    @required this.imageFile,
  }) : super(key: key);

  final Future<File> imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: FutureBuilder<File>(
        future: imageFile,
        builder: (_, snapshot) {
          final file = snapshot.data;
          if (file == null) return Container();
          return Image.file(file);
        },
      ),
    );
  }
}
