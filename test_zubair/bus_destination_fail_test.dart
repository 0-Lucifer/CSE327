import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tourify/bus_rent.dart';

void main() {
  testWidgets('Bus booking fails when From and To are same',
          (WidgetTester tester) async {
        // Load the BusRent widget inside MaterialApp
        await tester.pumpWidget(const MaterialApp(home: BusRent()));

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
        await tester.tap(find.text('Search Available Buses'));
        await tester.pumpAndSettle();

        // The bug: It still shows results instead of failing
        expect(find.textContaining('No buses found.'), findsOneWidget,
            reason: 'Booking should fail when origin and destination are same.');
      });
}
