import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/bus_model.dart';

void main() {
  group('Bus Model Tests', () {
    test('Bus properties are stored correctly', () {
      final bus = Bus(
        name: 'Dhaka Express',
        type: 'AC',
        seats: 40,
        pricePerSeat: 300.0,
      );

      expect(bus.name, equals('Dhaka Express'));
      expect(bus.type, equals('AC'));
      expect(bus.seats, equals(40));
      expect(bus.pricePerSeat, equals(300.0));
    });

    test('Bus total price calculation works', () {
      final bus = Bus(
        name: 'Dhaka Express',
        type: 'AC',
        seats: 40,
        pricePerSeat: 300.0,
      );

      const passengers = 2;
      final total = bus.pricePerSeat * passengers;

      expect(total, equals(600.0));
    });
  });
}
