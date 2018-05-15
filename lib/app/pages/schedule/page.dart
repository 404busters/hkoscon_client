import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../../const.dart' show PrimaryColor;
import './state.dart' show Conference;
import './timetable.dart';

const _endpoint = 'https://hkoscon.ddns.net/api/v1/days/HKOSCon%202018';

class SchedulePage extends StatefulWidget {
  Conference conference;
  bool isError = false;

  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    this.fetchConference();
  }

  Future<void> fetchConference() async {
    this.setState(() {
    });

    final Response response = await get(_endpoint);
    if (response.statusCode != 200) {
      this.setState(() {
        this.widget.isError = true;
      });
    }
    final responseJson = json.decode(response.body);

    this.setState(() {
      debugPrint('Finish fetching');
      this.widget.conference = Conference.fromJson(responseJson);
    });
  }

  Widget buildBody() {
    if (this.widget.isError && this.widget.conference == null) {
      return this.buildErrorBody();
    } else if (this.widget.conference != null) {
      return new TabBarView(
        children: this.widget.conference.days
            .map((day) => DayView(day))
            .toList(growable: false),
      );
    }

    return const Text('nothing');
  }

  Widget buildErrorBody() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Center(
          child: const Text(
            'Sorry, something wrong when loading from remote',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  List<Tab> buildTabs() {
    if (this.widget.conference == null) {
      return <Tab>[const Tab(text: 'Loading')];
    }
    return this.widget.conference.days
        .map((day) => new Tab(text: 'Day ${day.day} (${day.date})'))
        .toList();
  }

  Widget buildRefreshButton() {
    return new FloatingActionButton(
      onPressed: () {this.fetchConference();},
      foregroundColor: PrimaryColor,
      child: const Icon(Icons.autorenew),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.conference == null) {
      return new Scaffold(
        floatingActionButton: this.buildRefreshButton(),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: const Text(
                'Loading timetable from remote server',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return new DefaultTabController(
        length: this.widget.conference.days.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new TabBar(tabs: this.buildTabs()),
          ),
          floatingActionButton: this.buildRefreshButton(),
          body: this.buildBody(),
        )
    );
  }
}
