import 'package:flutter/material.dart';

import '../../../../shared/layout/coming_soon_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'Compte',
      icon: Icons.person_rounded,
      message: 'Ton profil, ton abonnement et tes enseignes.',
    );
  }
}
