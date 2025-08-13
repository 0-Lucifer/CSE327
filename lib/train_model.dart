/// Train Booking — Model layer
///
/// Defines the immutable [Train] value object used across views and controllers.
class Train {
  /// Display name of the train. Example: "Sundarban Express".
  final String name;        // e.g., "Sundarban Express"

  /// Service class/type. Example: "InterCity", "Mail".
  final String type;        // e.g., "InterCity", "Mail"

  /// Total (or available) seats used for simple filtering.
  final int seats;          // total/available seats used for simple filtering

  /// Fare per passenger (per seat).
  final double pricePerSeat; // price per passenger

  /// Creates an immutable [Train] model.
  const Train({
    required this.name,
    required this.type,
    required this.seats,
    required this.pricePerSeat,
  });
}
