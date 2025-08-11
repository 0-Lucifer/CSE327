import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import from lib folder
import '../lib/hotel_controller.dart';
import '../lib/hotel_model.dart';
import '../lib/hotelHomePage.dart';
import '../lib/HotelBookingScreen.dart';

void main() {
  // HOTEL CONTROLLER TESTS
  group('HotelController Tests', () {
    /// Test that `getDestinations` returns a non-empty list
    /// and contains a known location from our data.
    test('getDestinations returns correct list', () {
      final controller = HotelController();
      final destinations = controller.getDestinations();

      expect(destinations, isNotEmpty, reason: 'Destinations list should not be empty');
      expect(destinations.contains("Cox's Bazar"), isTrue,
          reason: 'Cox\'s Bazar should be one of the destinations');
    });

    /// Test that `getHotelsByLocation` returns a valid
    /// list of Hotel objects for a given location.
    test('getHotelsByLocation returns hotels for a given location', () {
      final controller = HotelController();
      final hotels = controller.getHotelsByLocation("Cox's Bazar");

      expect(hotels, isA<List<Hotel>>(), reason: 'Should return a list of Hotel objects');
      expect(hotels.first.name, "Sayeman Beach Resort",
          reason: 'The first hotel in Cox\'s Bazar should be Sayeman Beach Resort');
    });
  });

  // UI NAVIGATION TESTS (VIEW LAYER)
  group('UI Tests', () {
    /// Test that tapping on a destination and then a hotel
    /// opens the HotelBookingScreen with correct data.
    testWidgets('Hotel list opens booking screen on tap', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HotelHomePage()));

      // Tap the first destination chip ("Cox's Bazar")
      await tester.tap(find.text("Cox's Bazar"));
      await tester.pumpAndSettle();

      // Tap the first hotel card
      await tester.tap(find.text("Sayeman Beach Resort"));
      await tester.pumpAndSettle();

      // Verify booking screen is displayed
      expect(find.byType(HotelBookingScreen), findsOneWidget,
          reason: 'Booking screen should open after selecting a hotel');
      expect(find.text("Sayeman Beach Resort"), findsOneWidget,
          reason: 'Selected hotel name should be shown on booking screen');
    });
  });

  // HOTEL BOOKING SCREEN INTERACTION TESTS
  group('HotelBookingScreen Interaction Tests', () {
    /// Helper function to build the booking screen widget
    Widget createBookingScreen() {
      return MaterialApp(
        home: HotelBookingScreen(
          hotelName: "Test Hotel",
          price: "৳1,000",
        ),
      );
    }

    /// Test that pressing the "+" button increases room count.
    testWidgets('Increase room count updates UI', (WidgetTester tester) async {
      await tester.pumpWidget(createBookingScreen());

      // Verify initial room count is 1
      expect(find.text('1'), findsOneWidget);

      // Tap the "+" button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify room count increased to 2
      expect(find.text('2'), findsOneWidget);
    });

    /// Test that pressing the "–" button decreases room count but not below 1.
    testWidgets('Decrease room count cannot go below 1', (WidgetTester tester) async {
      await tester.pumpWidget(createBookingScreen());

      // Tap the "-" button
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Verify still 1 (cannot go below)
      expect(find.text('1'), findsOneWidget);
    });

    /// Test that selecting a payment method updates the selection.
    testWidgets('Select payment method updates selection', (WidgetTester tester) async {
      await tester.pumpWidget(createBookingScreen());

      // Tap "PayPal" option
      await tester.tap(find.text('PayPal'));
      await tester.pump();

      // Verify PayPal is now selected
      final payPalTile = tester.widget<RadioListTile>(find.byType(RadioListTile).at(1));
      expect(payPalTile.groupValue, 'PayPal',
          reason: 'Payment method should update when selected');
    });

    /// Test that total price updates when increasing number of rooms.
    testWidgets('Total price updates correctly when rooms change', (WidgetTester tester) async {
      await tester.pumpWidget(createBookingScreen());

      // Initial total price for 1 room = 1000
      expect(find.text('Total Price: ৳1000.00'), findsOneWidget);

      // Increase to 3 rooms
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Now should be 3000
      expect(find.text('Total Price: ৳3000.00'), findsOneWidget);
    });

    /// Test that tapping "Book Now" shows confirmation dialog.
    testWidgets('Book Now shows confirmation dialog', (WidgetTester tester) async {
      await tester.pumpWidget(createBookingScreen());

      // Tap "Book Now" button
      await tester.tap(find.text('Book Now'));
      await tester.pumpAndSettle();

      // Verify dialog appears
      expect(find.text('Booking Confirmed'), findsOneWidget);
      expect(find.textContaining('Your booking at Test Hotel'), findsOneWidget);
    });
  });
}
