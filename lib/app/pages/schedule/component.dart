import 'package:flutter/material.dart';
import '../../widgets/drawer.dart';
import '../../const.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton(this._callback);

  final VoidCallback _callback;

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      elevation: 8.0,
      onPressed: _callback,
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      backgroundColor: PrimaryColor,
      child: const Icon(Icons.autorenew),
    );
  }
}

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

class ErrorView extends StatelessWidget {
  const ErrorView();

  @override
  Widget build(BuildContext context) {
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
}

class LoadingView extends StatelessWidget {
  const LoadingView(this.refreshButton);
  final Widget refreshButton;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: this.refreshButton,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
}
