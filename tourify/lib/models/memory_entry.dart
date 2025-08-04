/// Core data models for travel memory management.
/// 
/// This library provides the [MemoryEntry] class for representing individual
/// travel memories with photos, stories, and metadata. It includes JSON
/// serialization support for Firebase storage and utility methods for
/// memory management.
/// 
/// Example usage:
/// ```dart
/// final memory = MemoryEntry(
///   id: 'unique-id',
///   title: 'Amazing Sunset',
///   story: 'Beautiful sunset at the beach',
///   date: DateTime.now(),
///   photos: ['photo1.jpg', 'photo2.jpg'],
///   cityName: 'Bali',
/// );
/// ```
library;

/// Represents a travel memory entry with photos and story details.
/// 
/// A [MemoryEntry] contains all the information about a specific travel memory,
/// including photos, story text, date, and optional city association.
/// This is the core data model for storing user's travel experiences.
class MemoryEntry {
  /// Unique identifier for this memory entry.
  final String id;
  
  /// The title or headline of this memory.
  final String title;
  
  /// The detailed story or description of this memory.
  final String story;
  
  /// The date when this memory was created or when the experience happened.
  final DateTime date;
  
  /// List of photo file paths or URLs associated with this memory.
  final List<String> photos;
  
  /// Optional name of the city where this memory was created.
  final String? cityName;
  /// Creates a new [MemoryEntry] with the provided details.
  /// 
  /// All parameters except [cityName] are required.
  /// The [photos] list should contain valid file paths or URLs.
  MemoryEntry({
    required this.id,
    required this.title,
    required this.story,
    required this.date,
    required this.photos,
    this.cityName,
  });

  /// Creates a [MemoryEntry] from a JSON map.
  /// 
  /// Expects the JSON to contain all required fields with proper types.
  /// The date should be in ISO 8601 format for proper parsing.
  /// 
  /// Throws [FormatException] if the date string is invalid.
  factory MemoryEntry.fromJson(Map<String, dynamic> json) {
    return MemoryEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      story: json['story'] as String,
      date: DateTime.parse(json['date'] as String),
      photos: List<String>.from(json['photos'] as List),
      cityName: json['cityName'] as String?,
    );
  }

  /// Converts this [MemoryEntry] to a JSON map.
  /// 
  /// The date is converted to ISO 8601 string format for storage.
  /// Returns a map suitable for JSON serialization and Firebase storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'story': story,
      'date': date.toIso8601String(),
      'photos': photos,
      'cityName': cityName,
    };
  }

  /// Creates a copy of this [MemoryEntry] with optionally updated values.
  /// 
  /// Any parameter that is not provided will use the current value.
  /// This is useful for updating specific fields while keeping others unchanged.
  MemoryEntry copyWith({
    String? id,
    String? title,
    String? story,
    DateTime? date,
    List<String>? photos,
    String? cityName,
  }) {
    return MemoryEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      story: story ?? this.story,
      date: date ?? this.date,
      photos: photos ?? this.photos,
      cityName: cityName ?? this.cityName,
    );
  }

  /// The number of photos associated with this memory.
  int get photoCount => photos.length;
  
  /// Whether this memory has at least one photo.
  bool get hasPhotos => photos.isNotEmpty;
  
  /// The date formatted as DD/MM/YYYY for display purposes.
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// String representation of this memory entry.
  /// 
  /// Includes the ID, title, date, and photo count for debugging purposes.
  @override
  String toString() {
    return 'MemoryEntry(id: $id, title: $title, date: $date, photoCount: $photoCount)';
  }

  /// Whether two memory entries are equal based on their ID.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MemoryEntry && other.id == id;
  }

  /// Hash code based on the unique ID.
  @override
  int get hashCode => id.hashCode;
}