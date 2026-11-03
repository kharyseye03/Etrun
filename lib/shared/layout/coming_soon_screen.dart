import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../widgets/widgets.dart';

/// Écran d'onglet pas encore construit, avec son titre et un état vide.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            AppDimens.lg,
            AppDimens.screenPadding,
            120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.headline),
              Expanded(
                child: EmptyState(icon: icon, title: 'Bientôt ici', message: message),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
