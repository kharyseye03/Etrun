import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

/// Anneau de progression qui se remplit à l'apparition.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.value,
    this.size = 88,
    this.stroke = 8,
    this.color = AppColors.primaryText,
    this.child,
  });

  /// Entre 0 et 1.
  final double value;
  final double size;
  final double stroke;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0, 1)),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutCubic,
      builder: (_, progress, child) => CustomPaint(
        size: Size.square(size),
        painter: _RingPainter(progress: progress, stroke: stroke, color: color),
        child: SizedBox.square(dimension: size, child: Center(child: child)),
      ),
      child: child,
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress, required this.stroke, required this.color});

  final double progress;
  final double stroke;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(stroke / 2);

    canvas.drawArc(
      arcRect,
      0,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = AppColors.border,
    );

    if (progress <= 0) return;
    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: math.pi * 1.5,
          colors: [color.withValues(alpha: 0.35), color],
          stops: [0, progress],
          transform: const GradientRotation(-math.pi / 2),
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}
