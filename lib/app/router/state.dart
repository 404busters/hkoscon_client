import 'package:flutter/material.dart';
import 'router.dart';
import 'history.dart';

WidgetBuilder _notFound = (BuildContext context) => const Text('Loading');

class RouterState extends State<Router> {

  History _history;

  void push(String route) {
    this.setState(() {
      this._history.push(route);
    });
  }

  void replace(String route) {
    this.setState(() {
      this._history.replace(route);
    });
  }

  void pop() {
    this.setState(() {
      this._history.pop();
    });
  }

  WidgetBuilder _fetchWidget(String name) {
    if (widget.routes.containsKey(name)) {
      return widget.routes[name];
    } else {
      return _notFound;
    }
  }

  @override
  void initState() {
    super.initState();
    this._history = new History();
    this._history.push("/");
  }

  @override
  Widget build(BuildContext context) {
    var current = this._history?.current;
    var builder = this._fetchWidget(current);
    Widget child = builder(context);
    return widget.builder(context, child);
  }


}