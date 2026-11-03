import 'package:e_trun/features/home/data/models/membership.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('daysLeft reste entre 0 et la durée totale', () {
    final start = DateTime(2026, 1, 1);
    final membership = Membership(
      planName: 'Premium',
      gymName: 'FitClub',
      startDate: start,
      endDate: start.add(const Duration(days: 90)),
      status: MembershipStatus.active,
    );

    expect(membership.daysLeft(start.add(const Duration(days: 30))), 60);
    expect(membership.daysLeft(start.add(const Duration(days: 200))), 0);
    expect(membership.daysLeft(start.subtract(const Duration(days: 10))), 90);
  });
}
