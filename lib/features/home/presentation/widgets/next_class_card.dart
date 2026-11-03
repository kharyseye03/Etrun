import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../data/models/upcoming_class.dart';

/// Prochain cours réservé, avec compte à rebours en direct.
class NextClassCard extends StatefulWidget {
  const NextClassCard({super.key, required this.upcoming});

  final UpcomingClass upcoming;

  @override
  State<NextClassCard> createState() => _NextClassCardState();
}

class _NextClassCardState extends State<NextClassCard> {
  late final Timer _timer;
  Duration _left = Duration.zero;

  static final _hour = DateFormat('HH:mm', 'fr_FR');

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final left = widget.upcoming.startsAt.difference(DateTime.now());
    setState(() => _left = left.isNegative ? Duration.zero : left);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final c = widget.upcoming;
    final h = _two(_left.inHours);
    final m = _two(_left.inMinutes.remainder(60));
    final s = _two(_left.inSeconds.remainder(60));

    return EtCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('PROCHAIN COURS', style: AppTextStyles.badge.copyWith(color: AppColors.textHint)),
              const Spacer(),
              Text(
                '${_hour.format(c.startsAt)} · ${c.durationMinutes} min',
                style: AppTextStyles.data.copyWith(fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name, style: AppTextStyles.title),
                    const SizedBox(height: 2),
                    Text('${c.studio} · ${c.coach}', style: AppTextStyles.caption),
                  ],
                ),
              ),
              // Chaque chiffre glisse quand il change.
              Row(
                children: [
                  for (final (i, part) in [h, m, s].indexed) ...[
                    if (i > 0)
                      Text(':', style: AppTextStyles.data.copyWith(color: AppColors.secondary)),
                    _RollingDigits(value: part),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RollingDigits extends StatelessWidget {
  const _RollingDigits({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) => ClipRect(
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.6), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic))
              .animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
      ),
      child: Text(
        value,
        key: ValueKey(value),
        style: AppTextStyles.data.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
