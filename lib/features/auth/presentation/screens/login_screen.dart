import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/widgets.dart';
import '../widgets/auth_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Bon retour',
      subtitle: 'Connecte-toi pour retrouver ta salle.',
      fields: [
        const EtTextField(
          label: 'E-mail',
          hint: 'awa.diop@mail.com',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.alternate_email_rounded,
          textInputAction: TextInputAction.next,
        ),
        const EtTextField(
          label: 'Mot de passe',
          hint: '••••••••',
          obscure: true,
          prefixIcon: Icons.lock_outline_rounded,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Pressable(
            onTap: () {},
            child: Text(
              'Mot de passe oublié ?',
              style: AppTextStyles.caption.copyWith(color: AppColors.primaryText),
            ),
          ),
        ),
      ],
      footer: EtButton(
        label: 'Se connecter',
        onPressed: () => context.go(RoutePaths.home),
      ),
    );
  }
}
