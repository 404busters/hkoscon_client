import 'package:flutter/material.dart';
import 'const.dart' show AppTitle, PrimaryColor, SecondaryColor;
import 'about.dart' show AboutApp;

class AppContainer extends StatefulWidget {
  const AppContainer(this.child);

  final Widget child;

  @override
  _AppContainerState createState() => new _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {

  ListTile buildTile(BuildContext context, String title, IconData icon, String route) {
    return new ListTile(
      leading: new Icon(icon),
      title: new Text(title),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  Widget buildDrawer(BuildContext context) {
    DrawerHeader header = new DrawerHeader(
        decoration: new BoxDecoration(
          color: PrimaryColor,
        ),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                AppTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: SecondaryColor,
                  fontSize: 30.0,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        )
    );


    return new Drawer(
      child: new ListView(
        children: <Widget>[
          header,
          this.buildTile(context, 'Schedule', Icons.event, '/schedule'),
          new AboutApp(),
        ],
      ),
    );
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
