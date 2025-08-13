import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/train_rent.dart';

void main() {
  testWidgets('FAIL: passengers should not exceed 10', (tester) async {

    await tester.pumpWidget(const MaterialApp(home: TrainRent()));

    final plusButton = find.byIcon(Icons.add);
    expect(plusButton, findsOneWidget);

    for (int i = 0; i < 12; i++) {
      await tester.tap(plusButton);
      await tester.pump();
    }

    // At this point, the UI shows a number > 10 (e.g., "11").
    // We EXPECT a cap of 10 — so this assertion is wrong on purpose and will FAIL.
    expect(find.text('10'), findsOneWidget); // will fail because it's actually > 10
  });
}
