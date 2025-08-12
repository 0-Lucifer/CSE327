/// Transfers (Bus) Model layer
///
/// Represents a bus/operator entry used by the Transfers feature.
/// Kept intentionally minimal to mirror your train model structure.
class Bus {
  /// Display name of the bus/operator. Example: "Green Line".
  final String name;

  /// Service class/type. Example: "AC", "Non-AC".
  final String type;

  /// Total (or available) seats used for simple filtering.
  final int seats;

  /// Fare per passenger in BDT (৳).
  final double pricePerSeat;

  /// Creates an immutable [Bus] model.
  const Bus({
    required this.name,
    required this.type,
    required this.seats,
    required this.pricePerSeat,
  });
}
