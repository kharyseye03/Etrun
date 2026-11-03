import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/widgets.dart';
import '../widgets/kinetic_marquee.dart';

/// Premier lancement : Créer un compte / Se connecter.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final outlined = AppTextStyles.headline.copyWith(
      fontSize: 84,
      height: 1,
      letterSpacing: -3,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = AppColors.border,
    );
    final filled = AppTextStyles.headline.copyWith(
      fontSize: 84,
      height: 1,
      letterSpacing: -3,
      color: AppColors.surface,
    );

    return Scaffold(
      body: Stack(
        children: [
          // Halo vert discret en haut de l'écran.
          Positioned(
            top: -160,
            left: -80,
            right: -80,
            child: Container(
              height: 420,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.16),
                    AppColors.primary.withValues(alpha: 0),
                  ],
                ),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 0.9, end: 1.1, duration: 4.seconds, curve: Curves.easeInOut),
          ),

          // Mots géants qui défilent.
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Column(
              children: [
                KineticMarquee(text: 'FORCE  CARDIO  HIIT  ', style: outlined),
                KineticMarquee(text: 'YOGA  BOXE  MOBILITÉ  ', style: filled, reverse: true),
                KineticMarquee(
                  text: 'CROSS  PILATES  SPIN  ',
                  style: outlined,
                  duration: const Duration(seconds: 24),
                ),
              ],
            ).animate().fadeIn(duration: 1200.ms),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Wordmark(),
                  const Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Ta salle.\n'),
                        TextSpan(
                          text: 'Dans ta poche.',
                          style: TextStyle(color: AppColors.primaryText),
                        ),
                      ],
                    ),
                    style: AppTextStyles.headline.copyWith(fontSize: 44, letterSpacing: -1.8),
                  ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.2),
                  const SizedBox(height: AppDimens.md),
                  Text(
                    'Entre avec ton QR, réserve tes cours et suis chaque séance.',
                    style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                  ).animate().fadeIn(delay: 450.ms, duration: 600.ms).slideY(begin: 0.2),
                  const SizedBox(height: AppDimens.xxl),
                  EtButton(
                    label: 'Créer un compte',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => context.push(RoutePaths.register),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.4),
                  const SizedBox(height: AppDimens.md),
                  EtButton.secondary(
                    label: 'Se connecter',
                    onPressed: () => context.push(RoutePaths.login),
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.bolt_rounded, color: AppColors.onPrimary, size: 20),
        ),
        const SizedBox(width: AppDimens.sm),
        Text('ETRUN', style: AppTextStyles.cardTitle.copyWith(letterSpacing: 2)),
      ],
    ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2);
  }
}
