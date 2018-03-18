import 'types.dart';
export 'types.dart';

class EventEmitter<E extends Event> {
  Map<String, List<Listener<E>>> _listeners = new Map();
  List<Subscriber<E>> _subscribers = new List();

  void on(String event, Listener<E> listener) {
    if (!this._listeners.containsKey(event)) {
      this._listeners[event] = new List();
    }
    this._listeners[event].add(listener);
  }

  void fire(String eventType, E detail) {
    this._subscribers.forEach((subscriber) {
      subscriber(eventType, detail);
    });

    if (!this._listeners.containsKey(eventType)) {
      return;
    }

    this._listeners[eventType].forEach((listener) => listener(detail));

  }

  void subscribe(Subscriber subscriber) {
    this._subscribers.add(subscriber);
  }

}