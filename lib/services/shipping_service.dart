import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shipment_app/models/shipping_model.dart';
import '../core/env_service.dart';

class ShippingService {
  Future<double> fetchShippingRate(ShippingModel request) async {
    final String shippoKey = EnvService.shippoTestKey; // Using your getter

    final response = await http.post(
      Uri.parse("https://api.goshippo.com/shipments/"),
      headers: {
        "Authorization": "ShippoToken $shippoKey",
        "Content-Type": "application/json",
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rates = data["rates"] as List;
      if (rates.isNotEmpty) {
        return double.parse(rates[0]["amount"]);
      } else {
        throw Exception("No shipping rates available");
      }
    } else {
      throw Exception("Failed to fetch shipping rates: ${response.body}");
    }
  }
}
