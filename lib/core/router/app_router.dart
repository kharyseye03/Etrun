import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/access_card/presentation/screens/access_card_screen.dart';
import '../../features/account/presentation/screens/account_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/classes/presentation/screens/planning_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/starter/presentation/screens/welcome_screen.dart';
import '../../features/training/presentation/screens/training_screen.dart';
import '../../shared/layout/main_shell.dart';

/// Route path constants.
abstract final class RoutePaths {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String planning = '/planning';
  static const String accessCard = '/card';
  static const String training = '/training';
  static const String account = '/account';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.welcome,
    routes: [
      GoRoute(
        path: RoutePaths.welcome,
        pageBuilder: (_, state) => _fade(state, const WelcomeScreen()),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (_, state, shell) => _fade(state, MainShell(shell: shell)),
        branches: [
          _branch(RoutePaths.home, const HomeScreen()),
          _branch(RoutePaths.planning, const PlanningScreen()),
          _branch(RoutePaths.accessCard, const AccessCardScreen()),
          _branch(RoutePaths.training, const TrainingScreen()),
          _branch(RoutePaths.account, const AccountScreen()),
        ],
      ),
    ],
  );
});

StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
    routes: [GoRoute(path: path, builder: (_, _) => screen)],
  );
}

/// Fondu pour les changements d'univers (accueil ↔ espace connecté).
CustomTransitionPage<void> _fade(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (_, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
  );
}
