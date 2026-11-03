import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';

/// Gros bouton « Ma carte » de l'accueil, balayé par un reflet.
class AccessCardCta extends StatelessWidget {
  const AccessCardCta({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        height: 92,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.onPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.qr_code_2_rounded, color: AppColors.primary, size: 30),
            ),
            const SizedBox(width: AppDimens.lg),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ma carte', style: AppTextStyles.title.copyWith(color: AppColors.onPrimary)),
                  Text(
                    'Présente ton QR à l\'accueil',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.65),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded, color: AppColors.onPrimary),
          ],
        ),
      )
          .animate(onPlay: (c) => c.repeat())
          .shimmer(
            delay: 2500.ms,
            duration: 1400.ms,
            color: Colors.white.withValues(alpha: 0.55),
            angle: 0.6,
          ),
    );
  }
}
