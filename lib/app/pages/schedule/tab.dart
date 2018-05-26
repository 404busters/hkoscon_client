import 'package:flutter/material.dart';
import 'state.dart';
import 'timetable.dart';
import 'component.dart';

class Body extends StatelessWidget {
  final Conference conference;
  final bool isError;
  const Body(this.conference, this.isError);

  @override
  Widget build(BuildContext context) {
    if (this.isError && this.conference == null) {
      return new ErrorView();
    } else if (this.conference != null) {
      return new TabBarView(
        children: this.conference.days
            .map((day) => DayView(day))
            .toList(growable: false),
      );
    }

    return const Text('nothing');

  }
}