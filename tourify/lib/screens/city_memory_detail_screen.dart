import 'package:flutter/material.dart';
import 'add_memory_screen.dart';
import '../models/city_memory.dart';
import '../models/memory_entry.dart';
import '../services/firebase_service.dart';

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
  List<MemoryEntry> _memoryEntries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMemoryEntries();
  }

  /// Loads memory entries for the selected city from Firebase
  Future<void> _loadMemoryEntries() async {
    print('🔥 Loading memories for city: ${widget.cityMemory.cityName}');
    
    try {
      setState(() {
        _isLoading = true;
      });
      
      final memories = await FirebaseService.getMemoriesForCity(widget.cityMemory.cityName);
      print('🔥 Loaded ${memories.length} memories from Firebase');
      
      setState(() {
        _memoryEntries = memories;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading memories: $e');
      setState(() {
        _memoryEntries = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          '${widget.cityMemory.cityName} Memories',
          style: const TextStyle(
            color: Color(0xFF1A237E),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A237E)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _addNewEntry,
            tooltip: 'Add Memory',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FA),
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildCityHeader(),
              Expanded(
                child: _isLoading
                    ? _buildLoadingState()
                    : _memoryEntries.isEmpty
                        ? _buildEmptyState()
                        : _buildMemoryList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds city header with summary info
  Widget _buildCityHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            const Color(0xFF3F51B5).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A237E).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A237E),
                  Color(0xFF283593),
                  Color(0xFF3F51B5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A237E).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.location_city,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.cityMemory.cityName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.cityMemory.photoCount} photos • ${_memoryEntries.length} memories',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF1A237E).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Last visited: ${_formatDate(widget.cityMemory.lastVisited)}',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF1A237E).withOpacity(0.6),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            const Color(0xFF3F51B5).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A237E).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatDate(entry.date),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              entry.story,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: const Color(0xFF1A237E).withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            _buildPhotoGrid(entry.photos),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${entry.photos.length} photos',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF1A237E).withOpacity(0.6),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A237E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => _editEntry(entry),
                        color: const Color(0xFF1A237E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () => _deleteEntry(entry),
                        color: Colors.red,
                      ),
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
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF1A237E).withOpacity(0.1),
                  const Color(0xFF3F51B5).withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1A237E).withOpacity(0.2),
                      const Color(0xFF3F51B5).withOpacity(0.2),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.image,
                  size: 40,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds loading state while fetching memories
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF1A237E),
          ),
          SizedBox(height: 16),
          Text(
            'Loading memories...',
            style: TextStyle(
              color: Color(0xFF1A237E),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds empty state when no memories exist
  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              const Color(0xFF3F51B5).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A237E).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1A237E).withOpacity(0.1),
                    const Color(0xFF3F51B5).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.photo_library_outlined,
                size: 80,
                color: const Color(0xFF1A237E).withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No memories for ${widget.cityMemory.cityName} yet',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF1A237E),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first memory!',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF1A237E).withOpacity(0.7),
              ),
            ),
          ],
        ),
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
        // Reload memories from Firebase to get the latest data
        _loadMemoryEntries();
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