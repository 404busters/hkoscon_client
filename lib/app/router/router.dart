import 'package:flutter/material.dart';
import 'types.dart';
import 'state.dart';

export 'types.dart';
export 'state.dart';

class Router extends StatefulWidget {
  const Router(this.routes, this.builder);

  final Map<String, WidgetBuilder> routes;
  final ContainerBuilder builder;

  @override
  RouterState createState() => new RouterState();

  static RouterState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<RouterState>());
  }
}