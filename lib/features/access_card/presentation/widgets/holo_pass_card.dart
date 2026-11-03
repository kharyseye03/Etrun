import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/access_pass.dart';

/// Carte de membre « holographique » : elle s'incline sous le doigt
/// et un reflet irisé la parcourt en continu.
class HoloPassCard extends StatefulWidget {
  const HoloPassCard({super.key, required this.pass});

  final AccessPass pass;

  @override
  State<HoloPassCard> createState() => _HoloPassCardState();
}

class _HoloPassCardState extends State<HoloPassCard>
    with TickerProviderStateMixin {
  late final _sheen = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  /// Inclinaison courante, en radians, sur chaque axe.
  Offset _tilt = Offset.zero;
  late final _release = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  Animation<Offset>? _back;

  @override
  void initState() {
    super.initState();
    _release.addListener(() {
      if (_back != null) setState(() => _tilt = _back!.value);
    });
  }

  @override
  void dispose() {
    _sheen.dispose();
    _release.dispose();
    super.dispose();
  }

  void _onPan(DragUpdateDetails d, Size size) {
    _release.stop();
    const max = 0.22;
    setState(() {
      _tilt = Offset(
        (_tilt.dx - d.delta.dy / size.height).clamp(-max, max),
        (_tilt.dy + d.delta.dx / size.width).clamp(-max, max),
      );
    });
  }

  void _onPanEnd(_) {
    HapticFeedback.selectionClick();
    _back = Tween(begin: _tilt, end: Offset.zero)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_release);
    _release.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final pass = widget.pass;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxWidth * 1.32);

        return GestureDetector(
          onPanUpdate: (d) => _onPan(d, size),
          onPanEnd: _onPanEnd,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateX(_tilt.dx)
              ..rotateY(_tilt.dy),
            child: SizedBox.fromSize(
              size: size,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusLg + 4),
                child: Stack(
                  children: [
                    // Fond graphite.
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF1E232A), Color(0xFF0C0E11)],
                          ),
                        ),
                      ),
                    ),
                    // Reflet irisé qui suit le temps et l'inclinaison.
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _sheen,
                        builder: (_, _) {
                          final t = _sheen.value * 2 * math.pi;
                          final shift = _tilt.dy * 4 + math.sin(t) * 0.6;
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-1.4 + shift, -1),
                                end: Alignment(1.4 + shift, 1),
                                colors: [
                                  Colors.transparent,
                                  AppColors.primary.withValues(alpha: 0.10),
                                  AppColors.info.withValues(alpha: 0.10),
                                  AppColors.secondary.withValues(alpha: 0.08),
                                  Colors.transparent,
                                ],
                                stops: const [0.25, 0.42, 0.52, 0.62, 0.78],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimens.radiusLg + 4),
                          border: Border.all(color: AppColors.borderRaised),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDimens.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bolt_rounded, color: AppColors.primaryText, size: 22),
                              const SizedBox(width: AppDimens.xs),
                              Text(
                                pass.gymName.toUpperCase(),
                                style: AppTextStyles.badge.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 1.6,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'MEMBRE',
                                style: AppTextStyles.badge.copyWith(color: AppColors.textHint),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Center(child: _QrBox(data: pass.qrData)),
                          const Spacer(),
                          Text(pass.memberName, style: AppTextStyles.title),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(pass.planName, style: AppTextStyles.caption),
                              const Spacer(),
                              Text(
                                pass.memberNumber,
                                style: AppTextStyles.data.copyWith(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QrBox extends StatelessWidget {
  const _QrBox({required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween(begin: 0.92, end: 1.0).animate(anim),
          child: child,
        ),
      ),
      child: Container(
        key: ValueKey(data),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        // Démo uniquement : en production on affiche l'image du serveur.
        child: QrImageView(
          data: data,
          size: 190,
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.textPrimary,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.circle,
            color: AppColors.background,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.circle,
            color: AppColors.background,
          ),
        ),
      ),
    );
  }
}
