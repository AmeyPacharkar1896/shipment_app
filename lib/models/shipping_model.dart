import 'dart:convert';

import 'package:shipment_app/models/address_model.dart';
import 'package:shipment_app/models/parcel_model.dart';

class ShippingModel {
  final AddressModel from;
  final AddressModel to;
  final ParcelModel parcel;
  final bool async;

  ShippingModel({
    required this.from,
    required this.to,
    required this.parcel,
    this.async = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'address_from': from.toMap(),
      'address_to': to.toMap(),
      'parcels': [parcel.toMap()],
      'async': async,
    };
  }

  String toJson() => json.encode(toMap());
}
