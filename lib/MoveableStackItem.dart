
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/camera_screen.dart';

class MoveableStackItem extends StatefulWidget {
  @override State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}
class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color;
  @override
  void initState() {
    color = Colors.blue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: yPosition,
      right: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: CameraScreen(),
      ),
    );
  }
}