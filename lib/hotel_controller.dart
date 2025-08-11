// hotel_controller.dart
import 'hotel_model.dart';

/// A controller class that manages hotel data and provides methods
/// to retrieve destinations and hotels based on location.
class HotelController {
  /// Stores hotels grouped by their location.
  /// The key is the location name (e.g., "Cox's Bazar"), and the value
  /// is a list of maps containing hotel details.
  final Map<String, List<Map<String, dynamic>>> _hotelsData = {
    "Cox's Bazar": [
      {
        "name": "Sayeman Beach Resort",
        "rating": 4.5,
        "reviews": 426,
        "price": "৳8,500",
        "discount": "10% Off",
      },
      {
        "name": "Seagull Hotel Ltd",
        "rating": 4.2,
        "reviews": 320,
        "price": "৳7,200",
        "discount": "5% Off",
      },
      {
        "name": "Ocean Paradise Hotel & Resort",
        "rating": 4.7,
        "reviews": 512,
        "price": "৳9,000",
        "discount": "15% Off",
      },
    ],
    "Teknaf": [
      {
        "name": "Hotel Ne-Taung",
        "rating": 3.9,
        "reviews": 120,
        "price": "৳5,500",
        "discount": "8% Off",
      },
      {
        "name": "Milky Resort",
        "rating": 4.1,
        "reviews": 210,
        "price": "৳6,800",
        "discount": "12% Off",
      },
    ],
    "Sajek": [
      {
        "name": "Sajek Resort",
        "rating": 4.2,
        "reviews": 310,
        "price": "৳6,000",
        "discount": "5% Off",
      },
      {
        "name": "Resort RungRang",
        "rating": 4.0,
        "reviews": 260,
        "price": "৳5,800",
        "discount": "8% Off",
      },
    ],
  };

  /// Returns a list of all available destinations.
  List<String> getDestinations() {
    return _hotelsData.keys.toList();
  }

  /// Retrieves a list of [Hotel] objects for the given location.
  /// If no hotels are found for the location, returns an empty list.
  List<Hotel> getHotelsByLocation(String location) {
    if (_hotelsData.containsKey(location)) {
      return _hotelsData[location]!.map((e) => Hotel.fromMap(e)).toList();
    }
    return [];
  }
}
