import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constants.dart';
import 'et_button.dart';

/// État vide : pas d'enseigne, pas d'abonnement, aucun cours…
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, color: AppColors.primaryText, size: 30),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(end: 1.06, duration: 1600.ms, curve: Curves.easeInOut),
            const SizedBox(height: AppDimens.xl),
            Text(title, style: AppTextStyles.title, textAlign: TextAlign.center),
            const SizedBox(height: AppDimens.sm),
            Text(message, style: AppTextStyles.caption, textAlign: TextAlign.center),
            if (actionLabel != null) ...[
              const SizedBox(height: AppDimens.xl),
              EtButton(label: actionLabel!, onPressed: onAction, expand: false),
            ],
          ],
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08),
      ),
    );
  }
}
