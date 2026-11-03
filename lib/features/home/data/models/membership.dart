enum MembershipStatus { active, expiringSoon, expired, suspended }

/// Abonnement du membre dans l'enseigne sélectionnée.
class Membership {
  const Membership({
    required this.planName,
    required this.gymName,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  final String planName;
  final String gymName;
  final DateTime startDate;
  final DateTime endDate;
  final MembershipStatus status;

  int get totalDays => endDate.difference(startDate).inDays;

  int daysLeft(DateTime now) =>
      endDate.difference(now).inDays.clamp(0, totalDays);
}
