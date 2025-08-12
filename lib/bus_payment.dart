import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bus_model.dart';

/// Transfers (Bus) View (payment)
///
/// Shows a receipt-style cost breakdown and simulates payment.
/// Mirrors your train payment screen structure and styling.
class BusPayment extends StatefulWidget {
  /// Selected [Bus] being booked.
  final Bus bus;

  /// Number of passengers in this booking.
  final int passengers;

  /// Origin station/hub name.
  final String from;

  /// Destination station/hub name.
  final String to;

  /// Creates a [BusPayment] screen with the provided booking details.
  const BusPayment({
    super.key,
    required this.bus,
    required this.passengers,
    required this.from,
    required this.to,
  });

  @override
  State<BusPayment> createState() => _BusPaymentState();
}

class _BusPaymentState extends State<BusPayment> {
  /// Whether a mock payment processing is ongoing.
  bool _processing = false;

  /// Subtotal calculated as `pricePerSeat * passengers`.
  double get _subtotal => widget.bus.pricePerSeat * widget.passengers;

  /// Service fee applied on subtotal. Adjust rate as needed.
  double get _serviceFee => _subtotal * 0.05; // 5%

  /// VAT calculation applied on subtotal. Adjust per local rules.
  double get _vat => _subtotal * 0.10; // 10%

  /// Final amount due.
  double get _total => _subtotal + _serviceFee + _vat;

  /// Simulates a payment call and shows a confirmation dialog.
  ///
  /// Replace with real payment SDK/API integration for production.
  Future<void> _confirmPayment() async {
    setState(() => _processing = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _processing = false);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Payment Successful',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Your booking for ${widget.bus.name} (${widget.bus.type}) is confirmed.\n'
              'From: ${widget.from}  →  To: ${widget.to}\n'
              'Passengers: ${widget.passengers}\n'
              'Total Paid: ৳${_total.toStringAsFixed(0)}',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context)..pop()..pop(),
            child: Text('Close', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  /// Renders a label-value pair row for the receipt card.
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

  @override
  Widget build(BuildContext context) {
    final t = GoogleFonts.poppins;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transfers Payment', style: t(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Receipt card: booking details and fare breakdown.
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _detailRow('Bus', '${widget.bus.name} (${widget.bus.type})'),
                    _detailRow('From', widget.from),
                    _detailRow('To', widget.to),
                    _detailRow('Passengers', '${widget.passengers}'),
                    const Divider(height: 24),
                    _detailRow('Subtotal', '৳${_subtotal.toStringAsFixed(0)}'),
                    _detailRow('Service Fee (5%)', '৳${_serviceFee.toStringAsFixed(0)}'),
                    _detailRow('VAT (10%)', '৳${_vat.toStringAsFixed(0)}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('TOTAL', style: t(fontWeight: FontWeight.w700, fontSize: 16)),
                        Text('৳${_total.toStringAsFixed(0)}', style: t(fontWeight: FontWeight.w700, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// Primary action: confirm payment (mock).
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processing ? null : _confirmPayment,
                child: _processing
                    ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text('Confirm Payment', style: t(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
