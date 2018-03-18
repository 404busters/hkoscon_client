class History {
  List<String> entries = new List<String>();

  void push(String route) {
    this.entries.add(route);
  }

  void replace(String route) {
    int last = this.entries.length - 1;
    this.entries[last] = route;
  }

  void pop() {
    if (this.entries.length > 0) {
      this.entries.removeLast();
    }
  }

  String get current => this.entries.length > 0 ? this.entries[this.entries.length - 1] : null;
}