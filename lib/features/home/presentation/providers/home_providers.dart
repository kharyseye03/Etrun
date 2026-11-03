import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/membership.dart';
import '../../data/models/upcoming_class.dart';

// Valeurs d'exemple le temps de construire l'UI. Au branchement de
// l'API, seuls ces providers changent : les écrans n'y verront rien.

final memberFirstNameProvider = Provider<String>((_) => 'Awa');

final membershipProvider = Provider<Membership?>((_) {
  final now = DateTime.now();
  return Membership(
    planName: 'Premium Illimité',
    gymName: 'FitClub Plateau',
    startDate: now.subtract(const Duration(days: 17)),
    endDate: now.add(const Duration(days: 73)),
    status: MembershipStatus.active,
  );
});

final upcomingClassProvider = Provider<UpcomingClass?>((_) {
  return UpcomingClass(
    name: 'HIIT Burn',
    studio: 'Studio 2',
    coach: 'Coach Ibrahima',
    startsAt: DateTime.now().add(const Duration(hours: 2, minutes: 45)),
    durationMinutes: 45,
  );
});

/// Statistiques du mois : séances, série en cours, calories.
final monthStatsProvider = Provider<({int sessions, int streak, int kcal})>(
  (_) => (sessions: 14, streak: 5, kcal: 6840),
);
