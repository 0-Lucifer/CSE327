/// Represents a Car entity in the rental system.
class Car {
  /// Name of the car (e.g., Toyota Noah).
  final String name;

  /// Type of car (e.g., SUV, Sedan, Minivan).
  final String type;

  /// Number of seats available in the car.
  final int seats;

  /// Rental price per day in USD.
  final double pricePerDay;

  /// Creates a [Car] instance with the given details.
  Car({
    required this.name,
    required this.type,
    required this.seats,
    required this.pricePerDay,
  });
}
