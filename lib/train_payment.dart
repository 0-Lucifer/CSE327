import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'train_model.dart';

class TrainPayment extends StatefulWidget {
  final Train train;
  final int passengers;
  final String from;
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
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _cardCtrl = TextEditingController();

  double get _totalPrice => widget.train.pricePerSeat * widget.passengers;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _cardCtrl.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Booking Successful'),
        content: Text('Your train booking has been confirmed!', style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
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
            Text('Trip Details', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _detailRow('From', widget.from),
            _detailRow('To', widget.to),
            _detailRow('Train', widget.train.name),
            _detailRow('Type', widget.train.type),
            _detailRow('Passengers', '${widget.passengers}'),
            _detailRow('Price / Seat', '\$${widget.train.pricePerSeat.toStringAsFixed(2)}'),
            const Divider(height: 32),
            Text('Payment Details', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                  ),
                  TextFormField(
                    controller: _cardCtrl,
                    decoration: const InputDecoration(labelText: 'Card Number'),
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.trim().length < 12) ? 'Enter a valid card number' : null,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Total: \$${_totalPrice.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _showSuccessDialog();
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007E95)),
                      child: Text('Pay & Book', style: GoogleFonts.poppins(color: Colors.white)),
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          Text(value, style: GoogleFonts.poppins()),
        ],
      ),
    );
  }
}