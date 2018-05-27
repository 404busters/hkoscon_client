import 'package:flutter/material.dart';
import '../const.dart' show PrimaryColor, SecondaryColor;
import 'about.dart' show AboutApp;
import '../config.dart';

class PageDrawer extends StatelessWidget {
  const PageDrawer();

  @override
  Widget build(BuildContext context) {
    return new AppDrawer(<DrawerItem>[
      new DrawerItem(
        title: 'Schedule',
        icon: Icons.event,
        route: '/',
      )
    ]);
  }
}


class AppDrawer extends StatelessWidget {
  const AppDrawer(this.items);

  final List<DrawerItem> items;
  Widget _buildHeader(BuildContext context) {
    const decoration = const BoxDecoration(
      color: PrimaryColor,
    );

    final config = ConfigState.remoteConfig(context);

    final Text title = new Text(
        config.getString('title_bar_text'),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: SecondaryColor,
          fontSize: 30.0,
          fontFamily: 'Open Sans',
        )
    );

    return new DrawerHeader(
        decoration: decoration,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              title,
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final header = this._buildHeader(context);
    List<Widget> children = <Widget>[header];
    children.addAll(this.items);
    children.add(new AboutApp());

    return new Drawer(
      child: new ListView(
        children: children,
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const DrawerItem({
    this.title,
    this.icon,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Icon(icon),
      title: new Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}