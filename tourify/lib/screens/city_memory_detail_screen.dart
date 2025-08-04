import 'package:flutter/material.dart';
import 'add_memory_screen.dart';
import '../models/city_memory.dart';
import '../models/memory_entry.dart';

/// City Memory Detail Screen - Shows photos and stories for a specific city
/// Displays user's personal diary entries for the selected city
class CityMemoryDetailScreen extends StatefulWidget {
  final CityMemory cityMemory;

  const CityMemoryDetailScreen({
    super.key,
    required this.cityMemory,
  });

  @override
  State<CityMemoryDetailScreen> createState() => _CityMemoryDetailScreenState();
}

class _CityMemoryDetailScreenState extends State<CityMemoryDetailScreen> {
  /// List of memory entries for this city
  /// In real app, this will be fetched from Firebase
  late List<MemoryEntry> _memoryEntries;

  @override
  void initState() {
    super.initState();
    _loadMemoryEntries();
  }

  /// Loads memory entries for the selected city
  void _loadMemoryEntries() {
    // Sample data - replace with Firebase data in real implementation
    _memoryEntries = [
      MemoryEntry(
        id: '1',
        title: 'Beautiful Sunset at ${widget.cityMemory.cityName}',
        story: 'Had an amazing evening watching the sunset. The colors were absolutely breathtaking!',
        date: DateTime(2024, 12, 15),
        photos: ['photo1.jpg', 'photo2.jpg'],
      ),
      MemoryEntry(
        id: '2',
        title: 'Local Food Experience',
        story: 'Tried the most delicious local cuisine. The flavors were incredible and the people were so welcoming.',
        date: DateTime(2024, 12, 14),
        photos: ['photo3.jpg'],
      ),
      MemoryEntry(
        id: '3',
        title: 'Exploring Historic Places',
        story: 'Visited some amazing historical sites. Learned so much about the rich culture and heritage.',
        date: DateTime(2024, 12, 13),
        photos: ['photo4.jpg', 'photo5.jpg', 'photo6.jpg'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cityMemory.cityName} Memories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _addNewEntry,
            tooltip: 'Add Memory',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCityHeader(),
          Expanded(
            child: _memoryEntries.isEmpty
                ? _buildEmptyState()
                : _buildMemoryList(),
          ),
        ],
      ),
    );
  }

  /// Builds city header with summary info
  Widget _buildCityHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal.shade400,
            Colors.teal.shade600,
          ],
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.location_city,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Text(
            widget.cityMemory.cityName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.cityMemory.photoCount} photos • ${_memoryEntries.length} memories',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          Text(
            'Last visited: ${_formatDate(widget.cityMemory.lastVisited)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds list of memory entries
  Widget _buildMemoryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _memoryEntries.length,
      itemBuilder: (context, index) {
        final entry = _memoryEntries[index];
        return _buildMemoryCard(entry);
      },
    );
  }

  /// Builds individual memory entry card
  Widget _buildMemoryCard(MemoryEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Text(
                  _formatDate(entry.date),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              entry.story,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            _buildPhotoGrid(entry.photos),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${entry.photos.length} photos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _editEntry(entry),
                      color: Colors.teal,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => _deleteEntry(entry),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds photo grid for memory entry
  Widget _buildPhotoGrid(List<String> photos) {
    if (photos.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.teal.shade100,
                child: const Icon(
                  Icons.image,
                  size: 40,
                  color: Colors.teal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds empty state when no memories exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No memories for ${widget.cityMemory.cityName} yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first memory!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  /// Handles adding new memory entry
  void _addNewEntry() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMemoryScreen(
          cityName: widget.cityMemory.cityName,
        ),
      ),
    ).then((result) {
      if (result != null && result is MemoryEntry) {
        setState(() {
          _memoryEntries.insert(0, result);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Memory added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  /// Handles editing memory entry
  void _editEntry(MemoryEntry entry) {
    // TODO: Implement edit entry functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit "${entry.title}" feature coming soon!'),
        backgroundColor: Colors.teal,
      ),
    );
  }

  /// Handles deleting memory entry
  void _deleteEntry(MemoryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Memory'),
          content: Text('Are you sure you want to delete "${entry.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _memoryEntries.remove(entry);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Memory deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// Formats date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}