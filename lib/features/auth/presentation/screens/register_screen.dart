import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/widgets.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Créer ton compte',
      subtitle: 'Un seul compte pour toutes tes salles.',
      fields: const [
        Row(
          children: [
            Expanded(child: EtTextField(label: 'Prénom', hint: 'Awa')),
            SizedBox(width: AppDimens.md),
            Expanded(child: EtTextField(label: 'Nom', hint: 'Diop')),
          ],
        ),
        EtTextField(
          label: 'E-mail',
          hint: 'awa.diop@mail.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.alternate_email_rounded,
        ),
        EtTextField(
          label: 'Téléphone',
          hint: '77 123 45 67',
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.phone_outlined,
        ),
        EtTextField(
          label: 'Mot de passe',
          hint: '8 caractères minimum',
          obscure: true,
          prefixIcon: Icons.lock_outline_rounded,
        ),
      ],
      footer: EtButton(
        label: 'Créer mon compte',
        onPressed: () => context.go(RoutePaths.home),
      ),
    );
  }
}
