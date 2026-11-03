import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import 'pressable.dart';

/// Carte de contenu : surface + filet de 1 pt, jamais d'ombre.
class EtCard extends StatelessWidget {
  const EtCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppDimens.lg),
    this.color = AppColors.surface,
    this.radius = AppDimens.radiusMd,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
    return onTap == null ? card : Pressable(onTap: onTap, child: card);
  }
}
