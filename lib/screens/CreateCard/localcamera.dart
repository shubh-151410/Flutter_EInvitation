import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalCamera extends StatefulWidget {
  var cameras;
  LocalCamera({this.cameras});
  @override
  _LocalCameraState createState() => _LocalCameraState();
}

class _LocalCameraState extends State<LocalCamera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller)),
              RaisedButton(
                
                  child: Text(
                    "Press",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: captureVideo,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)))
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  captureVideo() async {
    try {
      await _initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await _controller.takePicture().then((value) {
        if (value != null) {
          print(value);
        }
      }).catchError((error) => print(error));
    } catch (e) {}
  }
}
