import 'package:flutter/material.dart';
import 'state.dart';

class DayView extends StatelessWidget {
  final Day day;
  const DayView(this.day);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(20.0),
      child: new Text('${this.day.day} (${this.day.date})'),
    );
  }
}
