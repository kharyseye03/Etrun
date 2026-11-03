import 'dart:ui';

/// Palette d'e_trun, reprise de charte-graphique-mobile.md.
///
/// Accent : vert fluo, en attendant la décision de l'équipe.
///
/// La charte nomme l'accent « Vert Énergie » et demande du texte noir
/// dessus, mais donne l'hexa #3300FF (un bleu électrique). On suit
/// l'intention. Variante bleue testée : primary #3300FF,
/// onPrimary #F2F0E8 (le noir n'y contraste qu'à 2,5:1),
/// primaryText #8B7DFF (le bleu pur est illisible sur fond noir).
abstract final class AppColors {
  // ── Marque ─────────────────────────────────────────────
  /// Accent principal — boutons prioritaires, Pass QR, succès sportif.
  static const Color primary = Color(0xFFC6FF3D);
  /// Texte et icônes posés sur [primary].
  static const Color onPrimary = Color(0xFF060606);
  /// L'accent en texte, icône ou trait sur fond sombre.
  static const Color primaryText = Color(0xFFC6FF3D);
  /// Orange Sprint — effort, calories, compte à rebours, annulation.
  static const Color secondary = Color(0xFFFF6B00);

  // ── Surfaces (du plus sombre au plus clair) ────────────
  /// Fond d'écran absolu, noir OLED.
  static const Color background = Color(0xFF060606);
  /// Conteneurs secondaires, arrière-plan des listes.
  static const Color surfaceSunken = Color(0xFF0C0E11);
  /// Cartes de cours, fiches de séance, blocs de contenu.
  static const Color surface = Color(0xFF15181C);
  /// Bottom sheets et dialogues.
  static const Color surfaceRaised = Color(0xFF1E232A);
  /// Filet de 1 pt autour des cartes.
  static const Color border = Color(0xFF262B31);
  /// Séparateur supérieur des tiroirs et modales.
  static const Color borderRaised = Color(0xFF34383D);

  // ── Texte ──────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF2F0E8);
  static const Color textSecondary = Color(0xFFA8A598);
  static const Color textHint = Color(0xFF666C7B);

  // ── Statuts métier (fond du badge / texte et icône) ────
  static const Color successBg = Color(0xFF14532D);
  static const Color success = Color(0xFF22C55E);
  static const Color warningBg = Color(0xFF78350F);
  static const Color warning = Color(0xFFF59E0B);
  static const Color errorBg = Color(0xFF450A0A);
  static const Color error = Color(0xFFEF4444);
  static const Color infoBg = Color(0xFF0C4A6E);
  static const Color info = Color(0xFF38BDF8);
}
