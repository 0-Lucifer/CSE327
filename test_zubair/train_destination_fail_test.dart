import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tourify/train_rent.dart';

void main() {
  testWidgets('Train booking fails when From and To are same',
          (WidgetTester tester) async {
        // Load the TrainRent widget inside MaterialApp so it has all Material context
        await tester.pumpWidget(const MaterialApp(home: TrainRent()));

        // Open "From" dropdown
        await tester.tap(find.bySemanticsLabel('From'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Dhaka').last);
        await tester.pumpAndSettle();

        // Open "To" dropdown and select the same station
        await tester.tap(find.bySemanticsLabel('To'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Dhaka').last);
        await tester.pumpAndSettle();

        // Tap the search button
        await tester.tap(find.text('Search Available Trains'));
        await tester.pumpAndSettle();

        // The bug: It still shows results, so we expect it to fail if there's no prevention
        expect(find.textContaining('No trains found.'), findsOneWidget,
            reason: 'Booking should fail when origin and destination are same.');
      });
}
