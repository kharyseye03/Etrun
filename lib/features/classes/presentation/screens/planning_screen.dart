import 'package:flutter/material.dart';

import '../../../../shared/layout/coming_soon_screen.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'Planning',
      icon: Icons.calendar_month_rounded,
      message: 'Les cours de ta salle, jour par jour, avec réservation en un geste.',
    );
  }
}
