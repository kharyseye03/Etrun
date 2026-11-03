import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/access_pass.dart';

/// Durée de vie d'un QR avant qu'on en redemande un.
const qrLifetime = Duration(seconds: 60);

/// Pass courant. Valeurs d'exemple : sera remplacé par l'appel API.
class AccessPassNotifier extends Notifier<AccessPass> {
  @override
  AccessPass build() => _issue();

  AccessPass _issue() {
    final now = DateTime.now();
    return AccessPass(
      memberName: 'Awa Diop',
      memberNumber: 'FC-0042-1187',
      planName: 'Premium Illimité',
      gymName: 'FitClub Plateau',
      qrData: 'etrun-demo-${now.millisecondsSinceEpoch}',
      refreshAfter: now.add(qrLifetime),
    );
  }

  void refresh() => state = _issue();
}

final accessPassProvider =
    NotifierProvider<AccessPassNotifier, AccessPass>(AccessPassNotifier.new);
