import 'bus_model.dart';

/// Transfers (Bus) Controller layer
///
/// Provides read-only access to a Dhaka-focused in-memory dataset grouped
/// by origin hub/station. Mirrors your train controller API so the view
/// can call [getStations] and [getBusesByOrigin] the same way.
class BusController {
  /// Dhaka hubs/areas/terminals mapped to available buses from that origin.
  ///
  /// NOTE: Replace with a repository/API in production. Values are demo-friendly
  /// and recognizable for Dhaka (city + intercity operators).
  final Map<String, List<Bus>> _busData = {
    // Major intercity terminals
    'Gabtoli': [
      Bus(name: 'Shohagh Elite', type: 'AC', seats: 36, pricePerSeat: 1400),
      Bus(name: 'Hanif Enterprise', type: 'Non-AC', seats: 44, pricePerSeat: 750),
      Bus(name: 'Desh Travels', type: 'AC', seats: 40, pricePerSeat: 1200),
    ],
    'Mohakhali': [
      Bus(name: 'Ena Paribahan', type: 'Non-AC', seats: 44, pricePerSeat: 600),
      Bus(name: 'Shyamoli NR', type: 'AC', seats: 40, pricePerSeat: 1100),
      Bus(name: 'BRTC', type: 'AC', seats: 50, pricePerSeat: 800),
    ],
    'Sayedabad': [
      Bus(name: 'Green Line', type: 'AC', seats: 40, pricePerSeat: 1500),
      Bus(name: 'Eagle Paribahan', type: 'Non-AC', seats: 44, pricePerSeat: 700),
      Bus(name: 'SaintMartin Hyundai', type: 'AC', seats: 38, pricePerSeat: 1600),
    ],

    // City hubs/areas (for city routes / demo)
    'Uttara': [
      Bus(name: 'Victor Classic', type: 'Non-AC', seats: 44, pricePerSeat: 60),
      Bus(name: 'BRTC City', type: 'AC', seats: 50, pricePerSeat: 90),
    ],
    'Mirpur': [
      Bus(name: 'Basumati', type: 'Non-AC', seats: 44, pricePerSeat: 50),
      Bus(name: 'Turag', type: 'Non-AC', seats: 44, pricePerSeat: 45),
    ],
    'Motijheel': [
      Bus(name: 'BRTC Double Decker', type: 'AC', seats: 70, pricePerSeat: 100),
      Bus(name: 'Anabil Super', type: 'Non-AC', seats: 44, pricePerSeat: 55),
    ],
    'Gulshan': [
      Bus(name: 'Green Line City', type: 'AC', seats: 40, pricePerSeat: 150),
      Bus(name: 'Probhati-Banasree', type: 'Non-AC', seats: 42, pricePerSeat: 50),
    ],
    'Jatrabari': [
      Bus(name: 'Hanif City', type: 'AC', seats: 40, pricePerSeat: 120),
      Bus(name: 'Poribohon 6', type: 'Non-AC', seats: 44, pricePerSeat: 40),
    ],
  };

  /// Returns all available origin stations/hubs as a list of names.
  List<String> getStations() => _busData.keys.toList();

  /// Returns a list of [Bus] instances for a given [origin] hub.
  ///
  /// If the [origin] is not found, returns an empty list.
  List<Bus> getBusesByOrigin(String origin) => _busData[origin] ?? [];
}
