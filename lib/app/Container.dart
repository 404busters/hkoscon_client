import 'package:flutter/material.dart';
import 'const.dart' show AppTitle, SecondaryColor;

class AppContainer extends StatefulWidget {
  const AppContainer(this.child);

  final Widget child;

  @override
  _AppContainerState createState() => new _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  Widget buildDrawer(BuildContext context) {
    DrawerHeader header = new DrawerHeader(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Image.network('https://hkoscon.org/logo-72.png'),
              const Text(AppTitle),
            ],
          ),
        )
    );

    return new Drawer(
      child: new ListView(
        children: <Widget>[
          header,
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
