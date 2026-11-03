import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

enum BadgeStatus { success, warning, error, info }

/// Pastille de statut métier (actif, liste d'attente, expiré, info).
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.status});

  final String label;
  final BadgeStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      BadgeStatus.success => (AppColors.successBg, AppColors.success),
      BadgeStatus.warning => (AppColors.warningBg, AppColors.warning),
      BadgeStatus.error => (AppColors.errorBg, AppColors.error),
      BadgeStatus.info => (AppColors.infoBg, AppColors.info),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppDimens.xs + 2),
          Text(label.toUpperCase(), style: AppTextStyles.badge.copyWith(color: fg)),
        ],
      ),
    );
  }
}
