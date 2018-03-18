import 'package:flutter/material.dart';
import 'page.dart' show HomePage;

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Welcome to Hong Kong Open Source Conference 2018',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Text(
            'We hope you can enjoy in the conference',
            style: const TextStyle(
              fontSize: 12.0,
            ),
          )
        ],
      ),
    );
  }
}
