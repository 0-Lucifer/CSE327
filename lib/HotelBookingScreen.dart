// HotelBookingScreen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A screen that allows the user to book a selected hotel.
///
/// Displays hotel details, lets the user choose the number of rooms,
/// select a payment method, and confirm the booking.
class HotelBookingScreen extends StatefulWidget {
  /// Name of the hotel to be booked.
  final String hotelName;

  /// Price of one room in the hotel (formatted as a string with currency symbol).
  final String price;

  /// Creates a [HotelBookingScreen] with the given [hotelName] and [price].
  const HotelBookingScreen({
    super.key,
    required this.hotelName,
    required this.price,
  });

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  /// Number of rooms selected for booking.
  int numberOfRooms = 1;

  /// Currently selected payment method.
  String selectedPayment = "Credit Card";

  /// Calculates the total price based on the number of rooms and room price.
  double get totalPrice {
    // Extract numeric value from price string like "৳8,500"
    final numericPrice = double.tryParse(
          widget.price.replaceAll(RegExp(r'[^\d]'), ''),
        ) ??
        0;
    return numericPrice * numberOfRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Hotel", style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF264653),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Hotel details card
            Card(
              child: ListTile(
                title: Text(widget.hotelName,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: Text("Price per room: ${widget.price}"),
              ),
            ),
            const SizedBox(height: 16),

            /// Number of Rooms Selector
            Text("Number of Rooms:",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (numberOfRooms > 1) {
                      setState(() => numberOfRooms--);
                    }
                  },
                ),
                Text('$numberOfRooms',
                    style: GoogleFonts.poppins(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() => numberOfRooms++);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Payment Method Options
            Text("Payment Method",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500)),
            Column(
              children: ["Credit Card", "PayPal", "Debit Card"].map((method) {
                return RadioListTile<String>(
                  value: method,
                  groupValue: selectedPayment,
                  title: Text(method, style: GoogleFonts.poppins()),
                  onChanged: (value) =>
                      setState(() => selectedPayment = value!),
                );
              }).toList(),
            ),

            const SizedBox(height: 8),

            /// Total Price Display
            Text(
              "Total Price: ৳${totalPrice.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            /// "Book Now" Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF264653),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                onPressed: () {
                  // Show booking confirmation dialog
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Booking Confirmed"),
                      content: Text(
                        "Your booking at ${widget.hotelName} has been successful!",
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );
                },
                child: Text("Book Now",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
