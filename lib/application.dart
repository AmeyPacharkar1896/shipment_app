import 'package:flutter/material.dart';
import 'package:shipment_app/screens/book_shipment_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookShipmentPage(),
    );
  }
}
