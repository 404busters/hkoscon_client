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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            fontWeight: FontWeight.w500,
          ),
        )));

    return widgets;
  }
}

class EventView extends StatelessWidget {
  final Event event;
  const EventView(this.event);

  @override
  Widget build(BuildContext context) {
    final topic = new Text(event.display != null ? event.display : '???');
    return new Card(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new VenueView(event.venue),
              new Expanded(
                child: new Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: event.topic && event.speakers.length > 0 ? new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        topic,
                        new Text(
                          '${event.speakers.map((speaker) => speaker.name).join(' / ')}',
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ) : topic
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
    if (this.venue.name.length == 0) {
      return new CircleAvatar(child: const Text('SP'));
    }
    final String key = this.venue.name.substring(16, 17);
    return new CircleAvatar(child: new Text('H${key}'));
  }
}
