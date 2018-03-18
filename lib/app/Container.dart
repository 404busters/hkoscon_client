import 'package:flutter/material.dart';
import 'const.dart' show AppTitle, SecondaryColor;
import 'drawer.dart' show DrawerItem, AppDrawer;

class AppContainer extends StatefulWidget {
  const AppContainer(this.child);

  final Widget child;

  @override
  _AppContainerState createState() => new _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {

  Widget buildDrawer(BuildContext context) {

    return new AppDrawer(<DrawerItem>[
      new DrawerItem(
        title: 'Schedule',
        icon: Icons.event,
        route: '/schedule',
      ),

      new DrawerItem(
        title: 'Announcement',
        icon: Icons.message,
        route: '/',
      )
    ]);
  }

  Widget buildAppBar() {
    Text title = new Text(
        AppTitle,
        style: const TextStyle(
            color: SecondaryColor
        )
    );

    return new AppBar(
      elevation: 2.0,
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: this.buildAppBar(),
        body: widget.child,
        drawer: this.buildDrawer(context),
      ),
    );
  }
}