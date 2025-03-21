import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ShippingService {
  Future<double> fetchShippingRate({
    required String pickupAddress,
    required String deliveryAddress,
    required String courier,
  }) async {
    // Build your request JSON. For a real implementation, map your Flutter form data to these fields.
    final requestBody = jsonEncode({
      "address_from": {
        "name": "Sender Name",
        "street1": "123 Sender St",
        "city": "Sender City",
        "state": "ST",
        "zip": "12345",
        "country": "US",
        "phone": "1234567890",
        "email": "sender@example.com"
      },
      "address_to": {
        "name": "Recipient Name",
        "street1": "456 Recipient Ave",
        "city": "Recipient City",
        "state": "RS",
        "zip": "67890",
        "country": "US",
        "phone": "0987654321",
        "email": "recipient@example.com"
      },
      "parcels": [
        {
          "length": "10",
          "width": "15",
          "height": "10",
          "distance_unit": "in",
          "weight": "1",
          "mass_unit": "lb"
        }
      ],
      "async": false,
      // Optionally include carrier_accounts if you want to limit carriers
      //"carrier_accounts": ["carrier_account_id_1", "carrier_account_id_2"]
    });

    final String shippoTestKey = dotenv.env['SHIPPO_TEST_KEY'] ?? 'default_key';

    final response = await http.post(
      Uri.parse("https://api.goshippo.com/shipments/"),
      headers: {
        "Authorization": "ShippoToken $shippoTestKey",
        "Content-Type": "application/json",
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // The response will include a "rates" array. Choose one based on your criteria.
      final rates = data["rates"] as List;
      if (rates.isNotEmpty) {
        // For example, return the first rate as a double.
        return double.parse(rates[0]["amount"]);
      } else {
        throw Exception("No shipping rates available");
      }
    } else {
      throw Exception("Failed to fetch shipping rates: ${response.body}");
    }
  }
}
