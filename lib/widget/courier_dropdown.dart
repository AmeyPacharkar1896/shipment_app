import 'package:flutter/material.dart';

class CourierDropdown extends StatelessWidget {
  final String? selectedCourier;
  final Function(String?) onChanged;

  const CourierDropdown({
    super.key,
    required this.selectedCourier,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCourier,
      hint: const Text('Select Courier'),
      items: ['Delhivery', 'DTDC', 'Bluedart']
          .map((courier) => DropdownMenuItem(
                value: courier,
                child: Text(courier),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select a courier' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
