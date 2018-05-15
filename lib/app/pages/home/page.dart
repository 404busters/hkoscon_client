import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Center(
          child: const Text(
            'Welcome to Hong Kong Open Source Conference 2018',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        const Text(
          'We hope you can enjoy in the conference',
          style: const TextStyle(
            fontSize: 12.0,
          ),
        )
      ],
    );
  }
}
