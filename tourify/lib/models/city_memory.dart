/// City-based memory aggregation models for travel organization.
/// 
/// This library provides the [CityMemory] class for organizing travel memories
/// by destination. It aggregates photo counts, tracks visit dates, and manages
/// city-specific metadata for the travel diary interface.
/// 
/// Example usage:
/// ```dart
/// final cityMemory = CityMemory(
///   cityName: 'Paris',
///   photoCount: 25,
///   lastVisited: DateTime.now(),
///   thumbnailPath: 'assets/paris.jpg',
/// );
/// ```
library;

/// Represents a city with associated travel memories and photos.
/// 
/// A [CityMemory] aggregates information about a specific travel destination,
/// including the total number of photos taken there and the last visit date.
/// This model is used for displaying city-based memory collections.
class CityMemory {
  /// Unique identifier for this city memory record.
  final String id;
  
  /// The name of the city or travel destination.
  final String cityName;
  
  /// Total number of photos taken in this city across all memories.
  final int photoCount;
  
  /// The date of the most recent visit to this city.
  final DateTime lastVisited;
  
  /// Path to the thumbnail image representing this city.
  final String thumbnailPath;
  
  /// Creates a new [CityMemory] with the provided details.
  /// 
  /// If [id] is not provided, a unique ID is generated using the current timestamp.
  /// All other parameters are required for proper city memory representation.
  CityMemory({
    String? id,
    required this.cityName,
    required this.photoCount,
    required this.lastVisited,
    required this.thumbnailPath,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  /// Creates a [CityMemory] from a JSON map.
  /// 
  /// Expects the JSON to contain all required fields with proper types.
  /// The lastVisited date should be in ISO 8601 format for proper parsing.
  /// 
  /// Throws [FormatException] if the date string is invalid.
  factory CityMemory.fromJson(Map<String, dynamic> json) {
    return CityMemory(
      id: json['id'] as String,
      cityName: json['cityName'] as String,
      photoCount: json['photoCount'] as int,
      lastVisited: DateTime.parse(json['lastVisited'] as String),
      thumbnailPath: json['thumbnailPath'] as String,
    );
  }

  /// Converts this [CityMemory] to a JSON map.
  /// 
  /// The lastVisited date is converted to ISO 8601 string format for storage.
  /// Returns a map suitable for JSON serialization and Firebase storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cityName': cityName,
      'photoCount': photoCount,
      'lastVisited': lastVisited.toIso8601String(),
      'thumbnailPath': thumbnailPath,
    };
  }

  /// Creates a copy of this [CityMemory] with optionally updated values.
  /// 
  /// Any parameter that is not provided will use the current value.
  /// This is useful for updating specific fields while keeping others unchanged.
  CityMemory copyWith({
    String? id,
    String? cityName,
    int? photoCount,
    DateTime? lastVisited,
    String? thumbnailPath,
  }) {
    return CityMemory(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      photoCount: photoCount ?? this.photoCount,
      lastVisited: lastVisited ?? this.lastVisited,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    );
  }

  /// String representation of this city memory.
  /// 
  /// Includes the ID, city name, photo count, and last visited date for debugging.
  @override
  String toString() {
    return 'CityMemory(id: $id, cityName: $cityName, photoCount: $photoCount, lastVisited: $lastVisited)';
  }

  /// Whether two city memories are equal based on their ID.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CityMemory && other.id == id;
  }

  /// Hash code based on the unique ID.
  @override
  int get hashCode => id.hashCode;
}