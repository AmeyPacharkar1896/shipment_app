import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipment_app/bloc/shipment_bloc.dart';
import 'package:shipment_app/screens/book_shipment_screen.dart';

class BookShipmentPage extends StatelessWidget {
  const BookShipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ShipmentBloc(),
        child: BookShipmentScreen(),
      );
  }
}