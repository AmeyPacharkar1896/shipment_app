
class AddressModel {
  final String name;
  final String street1;
  final String city;
  final String state;
  final String zip;
  final String country;
  final String phone;
  final String email;

  AddressModel({
    required this.name,
    required this.street1,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'street1': street1,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'phone': phone,
      'email': email,
    };
  }
}