// hotel_model.dart

/// A model class that represents a hotel.
class Hotel {
  /// Name of the hotel.
  final String name;

  /// Average rating of the hotel (out of 5).
  final double rating;

  /// Number of customer reviews.
  final int reviews;

  /// Price of one room (in local currency, formatted as a string).
  final String price;

  /// Discount offer available for the hotel.
  final String discount;

  /// Creates a new [Hotel] object with the given details.
  Hotel({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.discount,
  });

  /// Creates a [Hotel] instance from a [Map] of hotel data.
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'],
      rating: map['rating'],
      reviews: map['reviews'],
      price: map['price'],
      discount: map['discount'],
    );
  }
}
