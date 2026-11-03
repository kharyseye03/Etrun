import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import 'pressable.dart';

enum EtButtonVariant { primary, secondary, ghost }

/// Bouton de l'app. Une seule variante [EtButtonVariant.primary] par écran.
class EtButton extends StatelessWidget {
  const EtButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = EtButtonVariant.primary,
    this.expand = true,
  });

  const EtButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expand = true,
  }) : variant = EtButtonVariant.secondary;

  const EtButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expand = false,
  }) : variant = EtButtonVariant.ghost;

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final EtButtonVariant variant;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, borderColor) = switch (variant) {
      EtButtonVariant.primary =>
        (AppColors.primary, AppColors.onPrimary, Colors.transparent),
      EtButtonVariant.secondary =>
        (AppColors.surface, AppColors.textPrimary, AppColors.border),
      EtButtonVariant.ghost =>
        (Colors.transparent, AppColors.textSecondary, Colors.transparent),
    };

    return Pressable(
      onTap: onPressed,
      child: AnimatedOpacity(
        opacity: onPressed == null ? 0.4 : 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: AppDimens.buttonHeight,
          width: expand ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.xl),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: foreground),
                const SizedBox(width: AppDimens.sm),
              ],
              Text(label, style: AppTextStyles.button.copyWith(color: foreground)),
            ],
          ),
        ),
      ),
    );
  }
}
