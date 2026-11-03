import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../data/models/membership.dart';

/// État de l'abonnement, avec l'anneau des jours restants.
class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key, required this.membership});

  final Membership membership;

  static final _date = DateFormat('d MMM yyyy', 'fr_FR');

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final left = membership.daysLeft(now);
    final ratio = membership.totalDays == 0 ? 0.0 : left / membership.totalDays;

    final (label, status, ringColor) = switch (membership.status) {
      MembershipStatus.active => ('Actif', BadgeStatus.success, AppColors.primaryText),
      MembershipStatus.expiringSoon => ('Bientôt expiré', BadgeStatus.warning, AppColors.warning),
      MembershipStatus.expired => ('Expiré', BadgeStatus.error, AppColors.error),
      MembershipStatus.suspended => ('Suspendu', BadgeStatus.error, AppColors.error),
    };

    return EtCard(
      padding: const EdgeInsets.all(AppDimens.lg + 2),
      child: Row(
        children: [
          ProgressRing(
            value: ratio,
            color: ringColor,
            size: 84,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedCounter(
                  value: left,
                  style: AppTextStyles.data.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                Text('jours', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: AppDimens.lg + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusBadge(label: label, status: status),
                const SizedBox(height: AppDimens.sm + 2),
                Text(membership.planName, style: AppTextStyles.cardTitle),
                const SizedBox(height: AppDimens.xs),
                Text(
                  'Expire le ${_date.format(membership.endDate)}',
                  style: AppTextStyles.data.copyWith(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Affiché tant que le membre n'a pas d'abonnement actif.
class NoMembershipCard extends StatelessWidget {
  const NoMembershipCard({super.key, this.onChoose});

  final VoidCallback? onChoose;

  @override
  Widget build(BuildContext context) {
    return EtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pas encore d\'abonnement', style: AppTextStyles.cardTitle),
          const SizedBox(height: AppDimens.xs),
          Text(
            'Choisis une formule pour accéder à la salle et réserver tes cours.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppDimens.lg),
          EtButton(label: 'Choisir une offre', onPressed: onChoose),
        ],
      ),
    );
  }
}
