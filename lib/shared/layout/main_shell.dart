import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';

/// Squelette des écrans connectés : contenu + barre du bas flottante.
///
/// Chaque onglet garde sa propre pile de navigation (StatefulShellRoute),
/// on retrouve donc l'écran où on l'avait laissé en revenant dessus.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const _tabs = [
    (icon: Icons.home_outlined, active: Icons.home_rounded, label: 'Accueil'),
    (icon: Icons.calendar_month_outlined, active: Icons.calendar_month_rounded, label: 'Planning'),
    (icon: Icons.qr_code_2_rounded, active: Icons.qr_code_2_rounded, label: 'Ma carte'),
    (icon: Icons.fitness_center_outlined, active: Icons.fitness_center_rounded, label: 'Entraînement'),
    (icon: Icons.person_outline_rounded, active: Icons.person_rounded, label: 'Compte'),
  ];

  /// Index de l'onglet central « Ma carte », mis en avant.
  static const _cardIndex = 2;

  void _go(int index) {
    if (index == shell.currentIndex) return;
    HapticFeedback.selectionClick();
    shell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      extendBody: true,
      body: shell,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimens.lg,
          0,
          AppDimens.lg,
          bottomInset > 0 ? bottomInset : AppDimens.lg,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  for (var i = 0; i < _tabs.length; i++)
                    Expanded(
                      child: i == _cardIndex
                          ? _CardTab(
                              selected: shell.currentIndex == i,
                              onTap: () => _go(i),
                            )
                          : _NavTab(
                              icon: _tabs[i].icon,
                              activeIcon: _tabs[i].active,
                              label: _tabs[i].label,
                              selected: shell.currentIndex == i,
                              onTap: () => _go(i),
                            ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.textPrimary : AppColors.textHint;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              selected ? activeIcon : icon,
              key: ValueKey(selected),
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: AppTextStyles.badge.copyWith(
              color: color,
              letterSpacing: 0,
              fontSize: 10.5,
            ),
            child: Text(label, maxLines: 1, overflow: TextOverflow.fade, softWrap: false),
          ),
          const SizedBox(height: 4),
          // Témoin d'onglet actif : un point vert qui s'allonge.
          AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutBack,
            width: selected ? 16 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.primaryText,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

/// Onglet central : bouton rond vert, accès direct au Pass QR.
class _CardTab extends StatelessWidget {
  const _CardTab({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutBack,
          width: selected ? 56 : 50,
          height: selected ? 56 : 50,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.background,
              width: selected ? 3 : 0,
            ),
          ),
          child: const Icon(
            Icons.qr_code_2_rounded,
            color: AppColors.onPrimary,
            size: 26,
          ),
        ),
      ),
    );
  }
}
