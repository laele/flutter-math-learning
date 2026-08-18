import 'dart:math';

import 'package:flutter/widgets.dart';

class FloatingMathSymbolsBackground extends StatefulWidget {
  final int symbolCount;
  final Color color;
  final double opacity;

  const FloatingMathSymbolsBackground({super.key, required this.symbolCount, required this.color, required this.opacity});

  @override
  State<FloatingMathSymbolsBackground> createState() => _FloatingMathSymbolsBackgroundState();
}

class _FloatingMathSymbolsBackgroundState extends State<FloatingMathSymbolsBackground> with SingleTickerProviderStateMixin {
  static const symbols = ['+', '-', '×', '÷'];

  late final AnimationController _controller;
  late final List<_FloatingSymbolData> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    _particles = _generatePartcles();
  }

  List<_FloatingSymbolData> _generatePartcles() {
    final random = Random();
    return List.generate(
      widget.symbolCount,
      (index) {
        final isNumber = random.nextBool();
        final symbol = isNumber ? random.nextInt(10).toString() : symbols[random.nextInt(symbols.length)];

        return _FloatingSymbolData(
          symbol: symbol,
          left: random.nextDouble(),
          top: random.nextDouble(),
          size: 24 + random.nextDouble() * 80,
          baseRotation: random.nextDouble() * 2 * pi,
          driftSpeed: (1 + random.nextInt(3)).toDouble(),
          rotationSpeed: (random.nextBool() ? 1 : -1) * (1 + random.nextInt(2)).toDouble(),
          phaseOffset: random.nextDouble() * 2 * pi,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value * 2 * pi;
            return Stack(
              children: _particles.map((p) {
                final driftOffset = sin(t * p.driftSpeed + p.phaseOffset) * 20;
                final rotation = p.baseRotation + t * p.rotationSpeed;

                return Positioned(
                  left: p.left * constraints.maxWidth,
                  top: p.top * constraints.maxHeight + driftOffset,
                  child: Transform.rotate(
                    angle: rotation,
                    child: Text(
                      p.symbol,
                      style: TextStyle(
                        fontSize: p.size,
                        fontWeight: FontWeight.bold,
                        color: widget.color.withOpacity(widget.opacity),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _FloatingSymbolData {
  final String symbol;
  final double left;
  final double top;
  final double size;
  final double baseRotation;
  final double driftSpeed;
  final double rotationSpeed;
  final double phaseOffset;

  _FloatingSymbolData({
    required this.symbol,
    required this.left,
    required this.top,
    required this.size,
    required this.baseRotation,
    required this.driftSpeed,
    required this.rotationSpeed,
    required this.phaseOffset,
  });
}
