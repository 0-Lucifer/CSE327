import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'train_model.dart';

/// Train Booking — View (Payment & Confirmation)
///
/// Displays trip details, collects user payment information,
/// and shows a booking confirmation dialog upon successful payment.
class TrainPayment extends StatefulWidget {
  /// Selected train for booking
  final Train train;

  /// Number of passengers
  final int passengers;

  /// Origin station
  final String from;

  /// Destination station
  final String to;

  const TrainPayment({
    super.key,
    required this.train,
    required this.passengers,
    required this.from,
    required this.to,
  });

  @override
  State<TrainPayment> createState() => _TrainPaymentState();
}

class _TrainPaymentState extends State<TrainPayment> {
  /// Form key for payment validation
  final _formKey = GlobalKey<FormState>();

  /// Controller for name input
  final _nameCtrl = TextEditingController();

  /// Controller for email input
  final _emailCtrl = TextEditingController();

  /// Controller for card number input
  final _cardCtrl = TextEditingController();

  /// Calculates total price for the booking
  double get _totalPrice =>
      widget.train.pricePerSeat * widget.passengers;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _cardCtrl.dispose();
    super.dispose();
  }

  /// Displays a success dialog after booking confirmation
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Booking Successful'),
        content: Text(
          'Your train booking has been confirmed!',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (r) => r.isFirst),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Booking', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF264653),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip details section
            Text(
              'Trip Details',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _detailRow('From', widget.from),
            _detailRow('To', widget.to),
            _detailRow('Train', widget.train.name),
            _detailRow('Type', widget.train.type),
            _detailRow('Passengers', '${widget.passengers}'),
            _detailRow(
              'Price / Seat',
              '\$${widget.train.pricePerSeat.toStringAsFixed(2)}',
            ),

            const Divider(height: 32),

            // Payment details section
            Text(
              'Payment Details',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Payment form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Full name input
                  TextFormField(
                    controller: _nameCtrl,
                    decoration:
                    const InputDecoration(labelText: 'Full Name'),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Required'
                        : null,
                  ),

                  // Email input
                  TextFormField(
                    controller: _emailCtrl,
                    decoration:
                    const InputDecoration(labelText: 'Email'),
                    validator: (v) =>
                    (v == null || !v.contains('@'))
                        ? 'Enter a valid email'
                        : null,
                  ),

                  // Card number input
                  TextFormField(
                    controller: _cardCtrl,
                    decoration:
                    const InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                    (v == null || v.trim().length < 12)
                        ? 'Enter a valid card number'
                        : null,
                  ),

                  const SizedBox(height: 16),

                  // Total price display
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total: \$${_totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Payment button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _showSuccessDialog();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007E95),
                      ),
                      child: Text(
                        'Pay & Book',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget to display a label-value pair in the trip details
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          Text(value, style: GoogleFonts.poppins()),
        ],
      ),
    );
  }
}
