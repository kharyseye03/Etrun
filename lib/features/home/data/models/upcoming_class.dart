/// Prochain cours réservé, affiché sur l'accueil.
class UpcomingClass {
  const UpcomingClass({
    required this.name,
    required this.studio,
    required this.coach,
    required this.startsAt,
    required this.durationMinutes,
  });

  final String name;
  final String studio;
  final String coach;
  final DateTime startsAt;
  final int durationMinutes;
}
