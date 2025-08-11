<<<<<<< HEAD
// hotelHomePage.dart
import 'package:flutter/material.dart';
import 'hotel_controller.dart';
import 'hotel_model.dart';
import 'HotelBookingScreen.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main homepage screen for viewing hotels by destination.
/// Allows users to select a destination and view a list of hotels.
/// Users can then navigate to the booking screen for any hotel.
class HotelHomePage extends StatelessWidget {
  /// Controller to manage hotel data.
  final HotelController _controller = HotelController();

  HotelHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get a list of available destinations from the controller.
    List<String> destinations = _controller.getDestinations();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels by Destination', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF264653),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Destination selection header
            Text(
              'Select a Destination',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            /// Destination chips
            Wrap(
              spacing: 10,
              children: destinations.map((location) {
                return ActionChip(
                  label: Text(location),
                  backgroundColor: const Color(0xFF007E95),
                  labelStyle: const TextStyle(color: Colors.white),
                  onPressed: () {
                    // Show hotels in a bottom sheet
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => HotelListSheet(
                        location: location,
                        hotels: _controller.getHotelsByLocation(location),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// A bottom sheet widget that displays a list of hotels for a given location.
/// [location] is the name of the destination.
/// [hotels] is the list of hotels available in that destination.
class HotelListSheet extends StatelessWidget {
  final String location;
  final List<Hotel> hotels;

  const HotelListSheet({
    super.key,
    required this.location,
    required this.hotels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Sheet header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hotels in $location",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF264653)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// List of hotels
          Expanded(
            child: hotels.isEmpty
                ? Center(child: Text("No hotels found."))
                : ListView.builder(
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to booking screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelBookingScreen(
                                hotelName: hotel.name,
                                price: hotel.price,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${hotel.rating} (${hotel.reviews} reviews)',
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Price: ${hotel.price} | ${hotel.discount}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';

class HotelHomePage extends StatelessWidget {
  const HotelHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Home'),
      ),
      body: Container(),
    );
  }
}
>>>>>>> b179ffad38b82b85779352ced9623b2c0a2bb0f8
