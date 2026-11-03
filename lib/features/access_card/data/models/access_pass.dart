/// Pass d'entrée du membre.
///
/// En production le QR arrive du serveur (image + expiration) via
/// GET /gym/attendance/me/access-qr : l'app ne le fabrique jamais.
class AccessPass {
  const AccessPass({
    required this.memberName,
    required this.memberNumber,
    required this.planName,
    required this.gymName,
    required this.qrData,
    required this.refreshAfter,
    this.invalidReason,
  });

  final String memberName;
  final String memberNumber;
  final String planName;
  final String gymName;
  final String qrData;
  final DateTime refreshAfter;

  /// Renseigné quand l'accès est refusé (expiré, suspendu…).
  final String? invalidReason;

  bool get isValid => invalidReason == null;
}
