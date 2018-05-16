import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import './state.dart';
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

  Widget buildDay(Day day) {
    return new CustomScrollView(
      key: new PageStorageKey<String>(day.date),
      slivers: <Widget>[
        new SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        new SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          sliver: new SliverFixedExtentList(
              itemExtent: 40.0,
              delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return DayView(day);
                  },
                  childCount: this.widget.conference.days.length
              )
          ),
        ),
      ],
    );
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
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      backgroundColor: PrimaryColor,
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
            const CircularProgressIndicator(),
            const Center(
              child: const Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: const Text(
                  'Loading timetable from remote server',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const Center(
              child: const Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: const Text(
                  'Welcome to Hong Kong Open Source Conference 2018',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                ),
              ),
            ),
            const Text(
              'We hope you can enjoy in the conference',
              style: const TextStyle(
                fontSize: 12.0,
                color: const Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return new DefaultTabController(
        length: this.widget.conference.days.length,
        child: new Scaffold(
            floatingActionButton: this.buildRefreshButton(),
            body: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    child: new SliverAppBar(
                      elevation: 2.0,
                      title: new TabBar(tabs: this.buildTabs()), // This is the title in the app bar.
                      forceElevated: innerBoxIsScrolled,
                    ),
                  )
                ];
              },
              body: this.buildBody(),
            )
        )
    );
  }
}
