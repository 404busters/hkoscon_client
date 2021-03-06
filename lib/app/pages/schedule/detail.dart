import 'package:flutter/material.dart';
import 'state.dart';
import '../../const.dart';
import '../../bibliothiki/html.dart';
import '../../widgets/divider.dart';

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
      appBar: new AppBar(
        title: new Text(
          event.display,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Open Sans',
          ),
        ),
      ),
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

    ];

    if (this.event.description.length > 0) {
      widgets.add(const HeightDivider(color: PrimaryColor, height: 2.0));
      widgets.add(new _AbstractCard(this.event.description));
    }

    this.event.speakers.forEach((speaker) {
      widgets.add(const HeightDivider(color: PrimaryColor, height: 2.0));
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
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child:  new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(this.title,
            style: const TextStyle(
              fontSize: 24.0,
              color: PrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _MetaRow(
                  Icons.event,
                  'Time',
                  '${this.date} (Day ${this.day}) ~ ${this.startTime}\u{00A0}\u{2011}\u{00A0}${this.endTime}',
                ),
                _MetaRow(
                  Icons.explore,
                  'Venue',
                  this.venue,
                ),
                _MetaRow(
                  Icons.message,
                  'Language',
                  this.language.length > 0 ? this.language : '??',
                ),
                _MetaRow(
                  Icons.network_check,
                  'Level',
                  this.level.length > 0 ? this.level : 'TBD',
                ),
              ],
            ),
          ),
        ],
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
    return new Container(
      child: new Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new Icon(this.icon, color: Colors.black87,),
            ),
            new Expanded(
              child: new Text(this.content.length > 0 ? this.content : '??'),
            )
          ],
        ),
      )
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
    return new Container(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Abstract',
            style: const TextStyle(
              fontSize: 20.0,
              color: PrimaryColor,
            ),
          ),
          new Padding (
            padding: const EdgeInsets.only(top: 12.0),
            child: new Text(
              cleanHTML(abstract),
              style: const TextStyle(
                height: 1.1,
                fontFamily: 'Open Sans',
              ),
            ),
          ),
        ],
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
    return new Container(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new SizedBox(
            height: 250.0,
            child: new Stack(
              children: <Widget>[
                new Positioned.fill(
                  child: new Image.network(
                    _imageUrl,
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
          new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new Text(
              _meta,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          new Padding (
            padding: const EdgeInsets.only(top: 12.0),
            child: new Text(
              cleanHTML(this.speaker.description),
              style: const TextStyle(
                height: 1.2,
                fontFamily: 'Open Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  get _meta {
    if (this.speaker.community.length > 0) {
      return '${this.speaker.community} / ${this.speaker.country}';
    }

    return this.speaker.country;
  }

  get _imageUrl {
    if (this.speaker.thumbnail.length > 0) {
      return this.speaker.thumbnail;
    }
    return 'https://file.hkoscon.org/speakers/2017/unknown.png';
  }
}