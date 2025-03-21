import 'package:flutter/material.dart';

class AnimatedPriceDisplay extends StatelessWidget {
  final double rate;

  const AnimatedPriceDisplay({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Text(
        'Shipping Rate: \$${rate.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
