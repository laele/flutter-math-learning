mixin EventEmitter {
  int _eventCounter = 0;
  int nextEventId() => ++_eventCounter;
}
