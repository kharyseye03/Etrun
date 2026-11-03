import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';
import '../providers/access_card_providers.dart';
import '../widgets/holo_pass_card.dart';
import '../widgets/qr_validity_bar.dart';

class AccessCardScreen extends ConsumerWidget {
  const AccessCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pass = ref.watch(accessPassProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            AppDimens.lg,
            AppDimens.screenPadding,
            120,
          ),
          children: [
            Text('Ma carte', style: AppTextStyles.headline),
            const SizedBox(height: AppDimens.xs),
            Text(
              'Présente ce code à l\'accueil ou à la borne.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppDimens.xl),
            if (pass.isValid) ...[
              HoloPassCard(pass: pass)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scaleXY(begin: 0.94, curve: Curves.easeOutBack, duration: 700.ms),
              const SizedBox(height: AppDimens.xl),
              QrValidityBar(
                refreshAfter: pass.refreshAfter,
                lifetime: qrLifetime,
                onExpired: ref.read(accessPassProvider.notifier).refresh,
              ),
              const SizedBox(height: AppDimens.lg),
              Center(
                child: Text(
                  'Fais glisser ton doigt pour incliner la carte',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textHint),
                ),
              ),
            ] else
              EmptyState(
                icon: Icons.block_rounded,
                title: 'Accès indisponible',
                message: pass.invalidReason!,
                actionLabel: 'Renouveler',
                onAction: () {},
              ),
          ],
        ),
      ),
    );
  }
}
