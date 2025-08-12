import 'package:flutter/material.dart';
import 'bus_rent.dart';

/// Transfers (Bus) — Entry page
///
/// Keeps the home widget minimal and defers responsibilities to [BusRent].
class BusHomePage extends StatelessWidget {
  /// Creates the Transfers (Dhaka) home page
  const BusHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BusRent();
  }
}
