import 'package:flutter/foundation.dart';

mixin PausableActions {
  VoidCallback? _nextAction;

  void pauseFor(VoidCallback nextAction) {
    _nextAction = nextAction;
  }

  void continueAction() {
    final action = _nextAction;
    _nextAction = null;
    action?.call();
  }
}
