import 'package:flutter/material.dart';
import 'package:shipment_app/widget/shipment_form.dart';

class BookShipmentScreen extends StatelessWidget {
  const BookShipmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Shipment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: ShipmentForm(),
          ),
        ),
      ),
    );
  }
}
