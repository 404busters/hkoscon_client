import 'package:flutter/material.dart';

class HeightDivider extends StatelessWidget {
  const HeightDivider({
    this.color,
    this.height,
  });

  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 0.0,
      child: new Center(
        child: new Container(
          height: 0.0,
          margin: new EdgeInsetsDirectional.only(start: 0.0),
          decoration: new BoxDecoration(
            border: new Border(
              bottom: Divider.createBorderSide(context, color: color, width: this.height),
            ),
          ),
        ),
      ),
    );
  }
}