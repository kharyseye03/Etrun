import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.firstName, required this.gymName});

  final String firstName;
  final String gymName;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bonjour';
    if (hour < 18) return 'Bon après-midi';
    return 'Bonsoir';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$_greeting, $firstName', style: AppTextStyles.caption),
              const SizedBox(height: AppDimens.xs),
              // Sélecteur d'enseigne : changer de salle depuis l'accueil.
              Pressable(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        gymName,
                        style: AppTextStyles.headline.copyWith(fontSize: 24),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppDimens.xs),
                    const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ],
          ),
        ),
        _RoundIcon(icon: Icons.notifications_none_rounded, dot: true, onTap: () {}),
      ],
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.onTap, this.dot = false});

  final IconData icon;
  final VoidCallback onTap;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 22),
            if (dot)
              Positioned(
                top: 11,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
