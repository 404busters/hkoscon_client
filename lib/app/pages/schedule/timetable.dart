import 'package:flutter/material.dart';
import 'state.dart';
import '../../const.dart';
import 'detail.dart';

class DayView extends StatelessWidget {
  final Day day;
  const DayView(this.day);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: new ListView(
        children: day.timeslots
            .map((timeslot) => TimeslotView(timeslot, day.date, day.day))
            .toList(growable: false),
      ),
    );
  }
}

class TimeslotView extends StatelessWidget {
  final Timeslot timeslot;
  final String date;
  final int day;
  const TimeslotView(this.timeslot, this.date, this.day);

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
        .map<Widget>((event) => EventView(
      event,
      this.timeslot.startTime,
      this.timeslot.endTime,
      this.date,
      this.day,
    ))
        .toList(growable: true);

    widgets.insert(0, Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:Text('${timeslot.startTime} - ${timeslot.endTime}',
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: PrimaryColor,
            fontSize: 18.0,
          ),
        )));

    return widgets;
  }
}

class EventView extends StatelessWidget {
  final Event event;
  final String startTime;
  final String endTime;
  final String date;
  final int day;
  const EventView(this.event, this.startTime, this.endTime, this.date, this.day);

  Widget _buildCardContent() {
    final topic = event.display != null ? event.display : '???';
    if (!event.topic || event.speakers.length == 0) {
      return new Text(
          topic,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          )
      );
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          topic,
          style: const TextStyle(
            height: 1.2,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              event.speakers.map((speaker) => speaker.name).join(' / '),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!event.topic) {
      return this._buildCard();
    }

    return new InkResponse(
      child: this._buildCard(),
      onTap: () {
        debugPrint('Tap');
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new DetailView(event, this.startTime, this.endTime, this.date, this.day),
        ));
      },
    );
  }

  Widget _buildCard() {
    return new Card(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Row(
            children: <Widget>[
              new VenueView(event.venue),
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: this._buildCardContent(),
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
