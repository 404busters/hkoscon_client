import 'package:flutter/material.dart';
import 'types.dart' show ContainerBuilder;
import 'state.dart' show RouterState;
import 'history.dart' show HistoryEvent;

export 'types.dart';
export 'state.dart';

typedef void RouteObserver(String action, HistoryEvent event);

class Router extends StatefulWidget {
  const Router({
    this.routes,
    this.builder,
    this.observers: const <RouteObserver>[],
  });

  final Map<String, WidgetBuilder> routes;
  final ContainerBuilder builder;
  final List<RouteObserver> observers;

  @override
  RouterState createState() => new RouterState();

  static RouterState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<RouterState>());
  }
}