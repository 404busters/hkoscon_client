import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import './state.dart';
import './timetable.dart';
import './component.dart';

const _endpoint = 'https://hkoscon.ddns.net/api/v1/days/HKOSCon%202018';

class SchedulePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Conference conference;
  bool isError = false;

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
        this.isError = true;
      });
    }
    final responseJson = json.decode(response.body);

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
    return new Overlay(
        initialEntries:<OverlayEntry>[
          new OverlayEntry(
              builder: (context) => this.buildLayer()
          ),
        ]
    );
  }

  Widget buildLayer() {
    if (this.conference == null) {
      return new LoadingView(this.buildRefreshButton());
    }

    return new DefaultTabController(
        length: this.conference.days.length,
        child: new Scaffold(
            floatingActionButton: this.buildRefreshButton(),
            body: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    child: new SliverAppBar(
                      elevation: 2.0,
                      title: new TabBar(tabs: this._buildTabs()), // This is the title in the app bar.
                      forceElevated: innerBoxIsScrolled,
                    ),
                  )
                ];
              },
              body: this._buildBody(),
            )
        )
    );
  }
}
