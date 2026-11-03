import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';

/// Gabarit commun aux écrans d'authentification.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.footer,
  });

  final String title;
  final String subtitle;
  final List<Widget> fields;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimens.xl),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Pressable(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.arrow_back_rounded, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimens.xxl),
                  Text(title, style: AppTextStyles.headline),
                  const SizedBox(height: AppDimens.sm),
                  Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 15)),
                  const SizedBox(height: AppDimens.xxl),
                  for (final field in fields) ...[field, const SizedBox(height: AppDimens.lg)],
                ]
                    .animate(interval: 60.ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.15, curve: Curves.easeOutCubic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.xl,
                AppDimens.sm,
                AppDimens.xl,
                AppDimens.xl,
              ),
              child: footer,
            ),
          ],
        ),
      ),
    );
  }
}
