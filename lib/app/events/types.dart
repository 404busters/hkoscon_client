class Event {
  const Event();
}

typedef void Listener<E extends Event>(E event);
typedef void Subscriber<E extends Event>(String type, E event);