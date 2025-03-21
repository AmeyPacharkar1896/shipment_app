class ParcelModel {
  final String length;
  final String width;
  final String height;
  final String weight;

  ParcelModel({
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'length': length,
      'width': width,
      'height': height,
      'distance_unit': 'in',
      'weight': weight,
      'mass_unit': 'lb',
    };
  }
}
