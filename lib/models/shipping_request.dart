class ShippingRate {
  final double rate;

  ShippingRate({required this.rate});

  factory ShippingRate.fromJson(Map<String, dynamic> json) {
    return ShippingRate(
      rate: json['rate'] as double,
    );
  }
}
