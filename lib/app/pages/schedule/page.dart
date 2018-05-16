import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import './state.dart';
import './timetable.dart';
import './component.dart';
import '../../drawer.dart' show DrawerItem, AppDrawer;

const _endpoint = 'https://hkoscon.org/2018/data/timetable.json';

class SchedulePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Conference conference;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    this.fetchConference();
  }

  Future<Null> fetchConference() async {
    _refreshIndicatorKey.currentState.show();
    final Response response = await get(_endpoint);
    if (response.statusCode != 200) {
      this.setState(() {
        this.isError = true;
      });
    }
    final responseJson = json.decode(response.body);

    _scaffoldKey.currentState?.showSnackBar(
      new SnackBar(
          content: const Text('Finish Loading')
      ),
    );

    this.setState(() {
      debugPrint('Finish fetching');
      this.conference = Conference.fromJson(responseJson);
    });
  }

  Widget _buildBody() {
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

  List<Tab> _buildTabs() {
    return this.conference.days
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
    return new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: this.fetchConference,
      child: this.buildLayer(),
    );
  }

  Widget buildLayer() {
    if (this.conference == null) {
      return new LoadingView(this.buildRefreshButton());
    }

    final tabs = new DefaultTabController(
        length: this.conference.days.length,
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            elevation: 2.0,
            title: const Text(
                AppTitle,
                style: const TextStyle(
                    color: SecondaryColor
                )
            ),
            bottom: new TabBar(tabs: this._buildTabs()), // This is the title in the app bar.
          ),
          floatingActionButton: this.buildRefreshButton(),
          body: this._buildBody(),
          drawer: this._buildDrawer(),
        )
    );

    return tabs;
  }

  Widget _buildDrawer() {
    return new AppDrawer(<DrawerItem>[
      new DrawerItem(
        title: 'Schedule',
        icon: Icons.event,
        route: '/',
      )
    ]);
  }
}
