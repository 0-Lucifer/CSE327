import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/car_controller.dart';
import '../lib/car_model.dart';
import '../lib/car_rental_page.dart';
import '../lib/car_payment_screen.dart';

void main() {
  group('CarRentalPage Tests', () {
    testWidgets('Should display car rental options based on search filters', (WidgetTester tester) async {
      // Arrange: Set up the CarController with mock data
      final carController = CarController();

      // Build the CarRentalPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: CarRentalPage(),
        ),
      );

      // Act: Select a pickup location
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dhaka').last); // Choose Dhaka
      await tester.pumpAndSettle();

      // Act: Select a drop-off location
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cox’s Bazar').last); // Choose Cox's Bazar
      await tester.pumpAndSettle();

      // Act: Set the number of passengers
      await tester.tap(find.byIcon(Icons.add)); // Increase passengers
      await tester.pumpAndSettle();

      // Act: Press the search button
      await tester.tap(find.byType(ElevatedButton)); // Press "Search Available Cars"
      await tester.pumpAndSettle();

      // Assert: Verify that the available cars are listed based on filters
      expect(find.text('Toyota Noah'), findsOneWidget);
      expect(find.text('Nissan X-Trail'), findsOneWidget);
      expect(find.text('No cars found.'), findsNothing); // Ensure cars are available
    });

    testWidgets('Should update passenger count when + and - buttons are pressed', (WidgetTester tester) async {
      // Build the CarRentalPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: CarRentalPage(),
        ),
      );

      // Act: Initially, passenger count is 1
      expect(find.text('1'), findsOneWidget);

      // Act: Press the + button to increase the number of passengers
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Assert: Passenger count should be 2
      expect(find.text('2'), findsOneWidget);

      // Act: Press the - button to decrease the number of passengers
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      // Assert: Passenger count should be 1 again
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Should navigate to CarPaymentScreen on Book Now button click', (WidgetTester tester) async {
      // Arrange: Set up the CarController with mock data
      final carController = CarController();

      // Build the CarRentalPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: CarRentalPage(),
        ),
      );

      // Act: Select a pickup location and a drop-off location
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dhaka').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cox’s Bazar').last);
      await tester.pumpAndSettle();

      // Act: Set passengers to 2
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Act: Press the search button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Act: Press the "Book Now" button for the first car in the list
      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      // Assert: Ensure that we navigated to the CarPaymentScreen
      expect(find.byType(CarPaymentScreen), findsOneWidget);
    });
  });
}
