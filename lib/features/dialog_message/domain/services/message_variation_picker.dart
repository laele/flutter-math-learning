import 'dart:math';

class MessageVariationPicker {
  final Random _random;
  String? _lastPicked;

  MessageVariationPicker({Random? random}) : _random = random ?? Random();

  String pick(List<String> options) {
    if (options.isEmpty) return '';
    if (options.length == 1) return options.first;

    String candidate;
    do {
      candidate = options[_random.nextInt(options.length)];
    } while (candidate == _lastPicked);

    _lastPicked = candidate;
    return candidate;
  }
}
