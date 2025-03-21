import 'package:flutter/material.dart';

class PriceDisplay extends StatelessWidget {
  final double rate;

  const PriceDisplay({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Shipping Rate: \$${rate.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
