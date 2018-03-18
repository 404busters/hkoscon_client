import 'package:flutter/material.dart';
import 'const.dart' show AppTitle, SecondaryColor;

class AppContainer extends StatefulWidget {
  const AppContainer(this.child);

  final Widget child;

  @override
  _AppContainerState createState() => new _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(AppTitle,
            style: const TextStyle(
              color: SecondaryColor,
            )
        ),
      ),
      body: widget.child,
    );
  }
}
