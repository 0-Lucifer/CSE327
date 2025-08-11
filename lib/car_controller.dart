import 'car_model.dart';

/// Controller responsible for managing and retrieving car rental data.
class CarController {
  /// Internal data store mapping locations to their available cars.
  final Map<String, List<Car>> _carData = {
    'Dhaka': [
      Car(name: 'Toyota Noah', type: 'Minivan', seats: 7, pricePerDay: 80),
      Car(name: 'Honda Grace', type: 'Sedan', seats: 4, pricePerDay: 60),
    ],
    'Cox’s Bazar': [
      Car(name: 'Nissan X-Trail', type: 'SUV', seats: 5, pricePerDay: 100),
      Car(name: 'Suzuki WagonR', type: 'Hatchback', seats: 4, pricePerDay: 50),
    ],
    'Sajek': [
      Car(name: 'Land Cruiser', type: 'SUV', seats: 7, pricePerDay: 120),
      Car(name: 'Toyota Axio', type: 'Sedan', seats: 4, pricePerDay: 70),
    ],
    'Teknaf': [
      Car(name: 'Mitsubishi Pajero', type: 'SUV', seats: 6, pricePerDay: 110),
      Car(name: 'Nissan Sunny', type: 'Sedan', seats: 4, pricePerDay: 65),
    ],
  };

  /// Returns a list of all available rental locations.
  List<String> getLocations() => _carData.keys.toList();

  /// Returns a list of cars available at the given [location].
  /// Returns an empty list if no cars are found.
  List<Car> getCarsByLocation(String location) => _carData[location] ?? [];
}
