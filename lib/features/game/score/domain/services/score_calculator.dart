class ScoreCalculator {
  static int calculate({
    required Duration elapsed,
    required Duration referenceTime,
    required double questionWeight,
  }) {
    final speedMultiplier = (1.0 - (elapsed.inMilliseconds / referenceTime.inMilliseconds)).clamp(0.2, 1.0);
    const basePoint = 10;

    return (basePoint * speedMultiplier * questionWeight).round();
  }
}
