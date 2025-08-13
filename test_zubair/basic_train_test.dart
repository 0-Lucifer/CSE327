import 'package:flutter_test/flutter_test.dart';
import 'package:tourify/train_model.dart';

void main() {
  group('Train Model Tests', () {
    test('Train properties are stored correctly', () {
      final train = Train(
        name: 'Intercity Express',
        type: 'AC',
        seats: 50,
        pricePerSeat: 500.0,
      );

      expect(train.name, equals('Intercity Express'));
      expect(train.type, equals('AC'));
      expect(train.seats, equals(50));
      expect(train.pricePerSeat, equals(500.0));
    });

    test('Train total price calculation works', () {
      final train = Train(
        name: 'Intercity Express',
        type: 'AC',
        seats: 50,
        pricePerSeat: 500.0,
      );

      const passengers = 3;
      final total = train.pricePerSeat * passengers;

      expect(total, equals(1500.0));
    });
  });
}
