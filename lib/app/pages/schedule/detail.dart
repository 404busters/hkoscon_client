import 'package:flutter/material.dart';
import 'state.dart';
import '../../const.dart';

String cleanHTML(String html) {
  return html
      .replaceAll(new RegExp(r'<[/\w\s]+>'), '')
      .replaceAll(new RegExp(r'&nbsp;'), '');
}

class DetailView extends StatelessWidget {
  final Event event;
  final String startTime;
  final String endTime;
  final String date;
  final int day;
  const DetailView(this.event, this.startTime, this.endTime, this.date, this.day);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: this._buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new ListView(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                border: new Border(top: new BorderSide(color: themeData.disabledColor))
            ),
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this._buildChildren(),
            ),
          )
        ]
    );
  }

  List<Widget> _buildChildren() {
    final widgets = <Widget>[
      new _MetaCard(
        title: event.display,
        venue: event.venue.name,
        startTime: this.startTime,
        endTime: this.endTime,
        date: this.date,
        day: this.day,
        language: event.language,
        level: event.level,
      ),
      new _AbstractCard(this.event.description),
    ];

    this.event.speakers.forEach((speaker) {
      widgets.add(new _SpeakerCard(speaker));
    });

    return widgets;
  }
}

class _MetaCard extends StatelessWidget {
  final String title;
  final String venue;
  final String startTime;
  final String endTime;
  final String date;
  final int day;
  final String language;
  final String level;

  const _MetaCard({
    this.title,
    this.venue,
    this.startTime,
    this.endTime,
    this.date,
    this.day,
    this.language,
    this.level,
  });

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child:  new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.venue,
                style: const TextStyle(
                  color: PrimaryColor,
                  fontWeight: FontWeight.w600,
                )
            ),
            new Text(this.title,
              style: const TextStyle(
                fontSize: 24.0,
                color: PrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _MetaRow(
                    Icons.event,
                    'Time',
                    '${this.date} (Day ${this.day}) ~ ${this.startTime} - ${this.endTime}',
                  ),
                  _MetaRow(
                    Icons.message,
                    'Language',
                    this.language,
                  ),
                  _MetaRow(
                    Icons.network_check,
                    'Level',
                    this.level,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _MetaRow(this.icon, this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: new Icon(this.icon, color: Colors.black87,),
          ),
          new SizedBox(
            width: 80.0,
            child: new Text(this.title),
          ),
          new Expanded(child: new Text(this.content)),
        ],
      ),
    );
  }
}

class _AbstractCard extends StatelessWidget {
  final String abstract;
  const _AbstractCard(this.abstract);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: this._buildCard(),
    );
  }

  Widget _buildCard() {
    return new Card(
      elevation: 2.0,
      child: new Container(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Abstract',
              style: const TextStyle(
                fontSize: 24.0,
                color: PrimaryColor,
              ),
            ),
            new Padding (
              padding: const EdgeInsets.only(top: 12.0),
              child: new Text(
                cleanHTML(abstract),
                style: const TextStyle(
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeakerCard extends StatelessWidget {
  final Speaker speaker;

  const _SpeakerCard(this.speaker);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: this._buildCard(),
    );
  }

  Widget _buildCard() {
    return new Card(
      elevation: 2.0,
      child: new Container(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 184.0,
              child: new Stack(
                children: <Widget>[
                  new Positioned.fill(
                    child: new Image.network(
                      this.speaker.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  new Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: new FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: new Text(
                          this.speaker.name,
                          style: const TextStyle(
                            color: SecondaryColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Text(
              '${this.speaker.community} / ${this.speaker.country}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            new Padding (
              padding: const EdgeInsets.only(top: 12.0),
              child: new Text(
                cleanHTML(this.speaker.description),
                style: const TextStyle(
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}