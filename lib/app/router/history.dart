import '../events/emitter.dart';

class HistoryEvent extends Event {
  const HistoryEvent(
    this.route
  );

  final String route;
}

class History extends EventEmitter<HistoryEvent> {
  List<String> entries = new List<String>();
  String get current => this.entries.length > 0 ? this.entries[this.entries.length - 1] : null;

  void push(String route) {
    this.entries.add(route);
    this.fire("push", new HistoryEvent(route));
  }

  void replace(String route) {
    int last = this.entries.length - 1;
    this.entries[last] = route;
    this.fire("replace", new HistoryEvent(route));
  }

  void pop() {
    if (this.entries.length > 0) {
      this.entries.removeLast();
    }
    this.fire("pop", const HistoryEvent(''));
  }
}
