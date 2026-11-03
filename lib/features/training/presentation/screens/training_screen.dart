import 'package:flutter/material.dart';

import '../../../../shared/layout/coming_soon_screen.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'Entraînement',
      icon: Icons.fitness_center_rounded,
      message: 'Tes programmes, ta séance en cours et ton historique.',
    );
  }
}
