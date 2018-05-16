import 'package:flutter/material.dart';
import 'state.dart';
import '../../const.dart';

class DayView extends StatelessWidget {
  final Day day;
  const DayView(this.day);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: new ListView(
        children: day.timeslots
            .map((timeslot) => TimeslotView(timeslot))
            .toList(growable: false),
      ),
    );
  }
}

class TimeslotView extends StatelessWidget {
  final Timeslot timeslot;
  const TimeslotView(this.timeslot);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.buildChildren(),
          ),
        )
    );
  }

  List<Widget> buildChildren() {
    final List<Widget> widgets = this.timeslot.events
        .map<Widget>((event) => EventView(event))
        .toList(growable: true);

    widgets.insert(0, Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:Text('${timeslot.startTime} - ${timeslot.endTime}',
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: PrimaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        )));

    return widgets;
  }
}

class EventView extends StatelessWidget {
  final Event event;
  const EventView(this.event);

  Widget buildCardContent() {
    final topic = event.display != null ? event.display : '???';
    if (!event.topic || event.speakers.length == 0) {
      return new Text(
          topic,
          style: const TextStyle(fontSize: 16.0)
      );
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          topic,
          style: const TextStyle(
            height: 1.2,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              event.speakers.map((speaker) => speaker.name).join(' / '),
              style: const TextStyle(
                fontSize: 12.0,
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new VenueView(event.venue),
              new Expanded(
                child: new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: this.buildCardContent(),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class VenueView extends StatelessWidget {
  final Venue venue;
  const VenueView(this.venue);

  @override
  Widget build(BuildContext context) {
    Text content;
    if (this.venue.name.length == 0) {
      content = const Text('SP');
    } else if (this.venue.name.startsWith('Conference')) {
      content =  new Text('H${this.venue.name.substring(16, 17)}');
    } else {
      content = new Text(this.venue.name.substring(0, 2).toUpperCase());
    }

    return new CircleAvatar(child: content);
  }
}
