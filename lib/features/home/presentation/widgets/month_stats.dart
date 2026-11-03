import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';

/// Trois tuiles de chiffres clés du mois.
class MonthStats extends StatelessWidget {
  const MonthStats({
    super.key,
    required this.sessions,
    required this.streak,
    required this.kcal,
  });

  final int sessions;
  final int streak;
  final int kcal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Tile(icon: Icons.fitness_center_rounded, value: sessions, label: 'séances')),
        const SizedBox(width: AppDimens.md),
        Expanded(child: _Tile(icon: Icons.local_fire_department_rounded, value: streak, label: 'jours de série', accent: AppColors.secondary)),
        const SizedBox(width: AppDimens.md),
        Expanded(child: _Tile(icon: Icons.bolt_rounded, value: kcal, label: 'kcal', accent: AppColors.secondary)),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.value,
    required this.label,
    this.accent = AppColors.primaryText,
  });

  final IconData icon;
  final int value;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return EtCard(
      padding: const EdgeInsets.all(AppDimens.md + 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(height: AppDimens.md),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedCounter(
              value: value,
              style: AppTextStyles.data.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label, style: AppTextStyles.caption.copyWith(fontSize: 12), maxLines: 1),
          ),
        ],
      ),
    );
  }
}
