String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an address';
  }
  return null;
}
