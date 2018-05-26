import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:firebase_performance/firebase_performance.dart';
import '../../const.dart';
import './state.dart';
import '../../config.dart';
import '../../bibliothiki/store.dart';
import 'component.dart';
import 'tab.dart';

class SchedulePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Store store = const Store();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Conference _conference;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    this.loadFromLocal();
    this.fetchConference();
  }

  void loadFromLocal() {
    final loadFileTrace = FirebasePerformance.instance.newTrace('Load local');
    loadFileTrace
        .start()
        .then((_) => this.readTimetable())
        .then(
            (String data) {
          loadFileTrace.stop();
          if (data != null) {
            this.setState(() {
              debugPrint('Load local');
              final responseJson = json.decode(data);
              this._conference = Conference.fromJson(responseJson);
            });
          }
        }
    );
  }

  Future<File> writeTimetable(String json) async {
    final storeFileTrace = FirebasePerformance.instance.newTrace('Store local');
    await storeFileTrace.start();
    final result = await this.store.writeFile('timetable.json', json);
    await storeFileTrace.stop();
    debugPrint('Store timetable');
    return result;
  }

  Future<String> readTimetable() async {
    try {
      return this.store.readFile('timetable.json');
    } catch (e) {
      // If we encounter an error, return null
      return null;
    }
  }

  Future<Null>  _refresh() async {
    ConfigState.of(_refreshIndicatorKey.currentContext).refresh();
    await this.fetchConference();
  }

  Future<Null> fetchConference() async {
    final httpTrace = await FirebasePerformance.startTrace('fetch timetable');

    _refreshIndicatorKey.currentState.show();
    final config = ConfigState.of(_refreshIndicatorKey.currentContext).config;
    final Response response = await get(config.getString('timetable_endpoint'));
    if (response.statusCode != 200) {
      this.setState(() {
        this._isError = true;
      });
      return;
    }

    this.writeTimetable(response.body);
    final responseJson = json.decode(response.body);

    _scaffoldKey.currentState?.showSnackBar(
      new SnackBar(
          content: const Text('Finish Loading')
      ),
    );

    await httpTrace.stop();
    this.setState(() {
      debugPrint('Finish fetching');
      this._conference = Conference.fromJson(responseJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _ConferenceTimetable(
      conference: _conference,
      refresh: _refresh,
      isError: _isError,
      refreshIndicatorKey: _refreshIndicatorKey,
      scaffoldKey: _scaffoldKey,
    );
  }
}

class _ConferenceTimetable extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  final Conference conference;
  final RefreshCallback refresh;
  final bool isError;

  _ConferenceTimetable({
    this.conference,
    this.refresh,
    this.isError,
    this.scaffoldKey,
    this.refreshIndicatorKey,
  });

  void _callback() {
    this.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: refresh,
      child: Builder(
        builder: (BuildContext context) {
          if (this.conference == null) {
            return new LoadingView(new RefreshButton(_callback));
          }
          final config = ConfigState.of(context).config;
          final tabs = new DefaultTabController(
              length: this.conference.days.length,
              child: new Scaffold(
                key: scaffoldKey,
                appBar: new AppBar(
                  elevation: 2.0,
                  title: new Text(
                      config.getString('title_bar_text'),
                      style: const TextStyle(
                          color: SecondaryColor
                      )
                  ),
                  bottom: new TabBar(tabs: this.conference.days
                      .map((day) => new Tab(text: 'Day ${day.day} (${day.date})'))
                      .toList()), // This is the title in the app bar.
                ),
                floatingActionButton: new RefreshButton(_callback),
                body: new Body(conference, isError),
                drawer: const PageDrawer(),
              )
          );

          return tabs;
        },
      ),
    );
  }
}
