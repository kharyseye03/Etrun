import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Nombre qui défile de 0 jusqu'à [value] à l'apparition.
class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.style,
    this.duration = const Duration(milliseconds: 1200),
  });

  final int value;
  final TextStyle style;
  final Duration duration;

  static final _format = NumberFormat.decimalPattern('fr_FR');

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutExpo,
      builder: (_, v, _) => Text(_format.format(v.round()), style: style),
    );
  }
}
