import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'car_model.dart';

/// Screen for confirming car booking and processing payment.
class CarPaymentScreen extends StatefulWidget {
  /// Selected car to rent.
  final Car car;

  /// Number of passengers for the booking.
  final int passengers;

  const CarPaymentScreen({
    super.key,
    required this.car,
    required this.passengers,
  });

  @override
  State<CarPaymentScreen> createState() => _CarPaymentScreenState();
}

class _CarPaymentScreenState extends State<CarPaymentScreen> {
  /// Selected travel class.
  String selectedClass = 'Economy';

  /// Selected payment method.
  String paymentMethod = 'Credit Card';

  /// Calculates total price based on number of passengers and car rate.
  double get totalPrice => widget.car.pricePerDay * widget.passengers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Booking', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF264653),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Car details section
            Text(
              'Car Details',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: ListTile(
                title: Text(widget.car.name),
                subtitle:
                    Text('${widget.car.type} - ${widget.car.seats} seats'),
                trailing:
                    Text('\$${widget.car.pricePerDay.toStringAsFixed(2)} /day'),
              ),
            ),
            const SizedBox(height: 20),

            /// Passenger count
            Text('Number of Passengers: ${widget.passengers}',
                style: GoogleFonts.poppins()),

            const SizedBox(height: 20),

            /// Payment method selection
            Text('Payment Method',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: ['Credit Card', 'PayPal', 'Debit Card'].map((method) {
                return RadioListTile(
                  title: Text(method, style: GoogleFonts.poppins()),
                  value: method,
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            /// Total price display
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(fontSize: 16)),

            const SizedBox(height: 20),

            /// Booking button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showSuccessDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007E95),
                ),
                child: Text('Book Now',
                    style: GoogleFonts.poppins(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Displays a booking confirmation dialog.
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Booking Successful'),
        content: Text('Your car rental has been confirmed!',
            style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
