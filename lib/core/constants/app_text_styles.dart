import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Échelle typographique de la charte.
///
/// Geist pour le texte, Geist Mono pour tout ce qui se compte :
/// chronos, séries, montants, dates d'expiration.
abstract final class AppTextStyles {
  static const _tabular = [FontFeature.tabularFigures()];

  static TextStyle get _sans => GoogleFonts.geist(color: AppColors.textPrimary);
  static TextStyle get _mono => GoogleFonts.geistMono(
        color: AppColors.textPrimary,
        fontFeatures: _tabular,
      );

  /// Chronomètre, score — 40 pt.
  static TextStyle get display => _mono.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 1.05,
        letterSpacing: -1.5,
      );

  /// Titre principal d'écran — 28 pt.
  static TextStyle get headline => _sans.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.8,
      );

  /// Titre de section — 20 pt.
  static TextStyle get title => _sans.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.4,
      );

  /// Titre de carte, nom de cours — 17 pt.
  static TextStyle get cardTitle => _sans.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      );

  /// Corps de texte — 15 pt.
  static TextStyle get body => _sans.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.45,
      );

  /// Données et montants — 15 pt mono.
  static TextStyle get data => _mono.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  /// Légendes — 13 pt, couleur secondaire.
  static TextStyle get caption => _sans.copyWith(
        fontSize: 13,
        color: AppColors.textSecondary,
      );

  /// Badges et puces — 11 pt majuscules espacées.
  static TextStyle get badge => _sans.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      );

  /// Libellé de bouton — 16 pt.
  static TextStyle get button => _sans.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      );
}
