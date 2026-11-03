import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

/// Jauge qui se vide jusqu'au renouvellement du QR, puis appelle
/// [onExpired] pour en demander un nouveau.
class QrValidityBar extends StatefulWidget {
  const QrValidityBar({
    super.key,
    required this.refreshAfter,
    required this.lifetime,
    required this.onExpired,
  });

  final DateTime refreshAfter;
  final Duration lifetime;
  final VoidCallback onExpired;

  @override
  State<QrValidityBar> createState() => _QrValidityBarState();
}

class _QrValidityBarState extends State<QrValidityBar> {
  late Timer _timer;
  Duration _left = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(milliseconds: 250), (_) => _tick());
  }

  void _tick() {
    final left = widget.refreshAfter.difference(DateTime.now());
    if (left.isNegative) {
      widget.onExpired();
      return;
    }
    setState(() => _left = left);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _left.inMilliseconds / widget.lifetime.inMilliseconds;
    final seconds = _left.inSeconds + 1;

    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.shield_outlined, size: 16, color: AppColors.success),
            const SizedBox(width: AppDimens.xs + 2),
            Text('Code sécurisé', style: AppTextStyles.caption),
            const Spacer(),
            Text(
              'Nouveau code dans ${seconds}s',
              style: AppTextStyles.data.copyWith(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: ratio.clamp(0, 1)),
            duration: const Duration(milliseconds: 250),
            builder: (_, v, _) => LinearProgressIndicator(
              value: v,
              minHeight: 4,
              backgroundColor: AppColors.border,
              color: AppColors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}
