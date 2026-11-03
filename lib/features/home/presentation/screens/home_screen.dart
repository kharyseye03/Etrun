import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/router/app_router.dart';
import '../providers/home_providers.dart';
import '../widgets/access_card_cta.dart';
import '../widgets/home_header.dart';
import '../widgets/membership_card.dart';
import '../widgets/month_stats.dart';
import '../widgets/next_class_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(membershipProvider);
    final upcoming = ref.watch(upcomingClassProvider);
    final stats = ref.watch(monthStatsProvider);

    final sections = <Widget>[
      HomeHeader(
        firstName: ref.watch(memberFirstNameProvider),
        gymName: membership?.gymName ?? 'Ma salle',
      ),
      const SizedBox(height: AppDimens.xl),
      membership == null
          ? NoMembershipCard(onChoose: () {})
          : MembershipCard(membership: membership),
      const SizedBox(height: AppDimens.md),
      if (membership != null) ...[
        AccessCardCta(onTap: () => context.go(RoutePaths.accessCard)),
        const SizedBox(height: AppDimens.md),
      ],
      if (upcoming != null) ...[
        NextClassCard(upcoming: upcoming),
        const SizedBox(height: AppDimens.xl),
      ],
      Text('Ce mois-ci', style: AppTextStyles.title),
      const SizedBox(height: AppDimens.md),
      MonthStats(sessions: stats.sessions, streak: stats.streak, kcal: stats.kcal),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          // Marge basse : la barre de navigation flotte par-dessus.
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            AppDimens.lg,
            AppDimens.screenPadding,
            120,
          ),
          children: sections
              .animate(interval: 70.ms)
              .fadeIn(duration: 450.ms)
              .slideY(begin: 0.12, curve: Curves.easeOutCubic),
        ),
      ),
    );
  }
}
