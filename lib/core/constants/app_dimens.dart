/// Grille de 8 points et rayons de la charte.
abstract final class AppDimens {
  // ── Espacements ────────────────────────────────────────
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Marge latérale standard de tous les écrans.
  static const double screenPadding = lg;

  // ── Rayons ─────────────────────────────────────────────
  /// Petits boutons, filtres, champs de texte.
  static const double radiusSm = 8;
  /// Cartes de cours, exercices.
  static const double radiusMd = 14;
  /// Pass QR, bottom sheets.
  static const double radiusLg = 24;
  /// Pilule complète.
  static const double radiusPill = 999;

  static const double borderWidth = 1;

  /// Hauteur des boutons d'action principaux.
  static const double buttonHeight = 56;
}
