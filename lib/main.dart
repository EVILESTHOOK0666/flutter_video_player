import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/camera_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_pip/easy_pip.dart';
import 'package:test_app/MoveableStackItem.dart';

void main() {
  runApp(
    ChewieDemo(),
  );
}

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Flutter Test'});
  final String title;
  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  double xPosition = 0;
  double yPosition = 0;
  Color color;

  @override
  void initState() {
    color = Colors.blue;
    super.initState();
    this.initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
    await _videoPlayerController1.initialize();
    _videoPlayerController2 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    await _videoPlayerController2.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  var isEnabled = true;
  double top=0;
  double left=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Test"),
        ),
        body: Stack(
          children: <Widget>[
          Draggable(child: CameraScreen(),
              feedback: Container(height:500,width:500,padding: EdgeInsets.only(top: top, left: left),child:CameraScreen()),
              childWhenDragging:Container(height:150,width:150,padding: EdgeInsets.only(top: top, left: left),child:CameraScreen()),
              onDragCompleted: () {},
            onDragEnd: (drag) {
              setState(() {
                top = top + drag.offset.dy < 0 ? 0 : top + drag.offset.dy;

                left = left + drag.offset.dx < 0 ? 0 : left + drag.offset.dx;

              });
            },
          ),
            Container(
                child: Center(
                  child: _chewieController != null &&
                      _chewieController
                          .videoPlayerController.value.initialized
                      ? Chewie(
                    controller: _chewieController,
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Loading'),
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