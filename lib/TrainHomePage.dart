/// Train Booking — Entry page
///
/// Minimal wrapper that returns the rent/search view.
import 'package:flutter/material.dart';
import 'train_rent.dart';

/// Home page that loads [TrainRent].
class TrainHomePage extends StatelessWidget {
  const TrainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrainRent();
  }
}
