import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipment_app/models/address_model.dart';
import 'package:shipment_app/models/parcel_model.dart';
import 'package:shipment_app/models/shipping_model.dart';
import '../bloc/shipment_bloc.dart';
import 'address_input_field.dart';
import 'courier_dropdown.dart';
import 'animated_price_display.dart';
import '../core/utils/validations.dart';

class ShipmentForm extends StatefulWidget {
  const ShipmentForm({Key? key}) : super(key: key);

  @override
  _ShipmentFormState createState() => _ShipmentFormState();
}

class _ShipmentFormState extends State<ShipmentForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // These controllers now represent the basic pickup and delivery addresses.
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  String? _selectedCourier; // Currently selected courier (for UI purpose)

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize fade-in animation for the form.
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pickupController.dispose();
    _deliveryController.dispose();
    super.dispose();
  }

  // In this example, we use the pickup field as a sender street and the delivery field as a recipient street.
  // Other address details use default placeholders. You can later expand the UI to collect these details.
  void _onCalculatePressed() {
    if (_formKey.currentState!.validate() && _selectedCourier != null) {
      // Build sender Address with default values for missing fields.
      final sender = AddressModel(
        name: "Default Sender",
        street1: _pickupController.text,
        city: "City", // placeholder
        state: "State", // placeholder
        zip: "00000", // placeholder
        country: "US",
        phone: "0000000000",
        email: "sender@example.com",
      );

      // Build recipient Address with default values.
      final recipient = AddressModel(
        name: "Default Recipient",
        street1: _deliveryController.text,
        city: "City",
        state: "State",
        zip: "00000",
        country: "US",
        phone: "0000000000",
        email: "recipient@example.com",
      );

      // Use dummy parcel details (you can later add dedicated fields for these).
      final parcel = ParcelModel(
        length: "10",
        width: "15",
        height: "10",
        weight: "1",
      );

      // Create the shipment request model.
      final shipmentRequest = ShippingModel(
        addressFrom: sender,
        addressTo: recipient,
        parcel: parcel,
        async: false,
      );

      // Dispatch the event with the complete ShipmentRequest.
      BlocProvider.of<ShipmentBloc>(context)
          .add(ShippingRateRequested(shipmentRequest: shipmentRequest));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Use AddressInputField for pickup and delivery addresses.
            AddressInputField(
              controller: _pickupController,
              label: 'Pickup Address (Street)',
              validator: validateAddress,
            ),
            const SizedBox(height: 16),
            AddressInputField(
              controller: _deliveryController,
              label: 'Delivery Address (Street)',
              validator: validateAddress,
            ),
            const SizedBox(height: 16),
            // Courier selection remains; you might later use this to filter carriers.
            CourierDropdown(
              selectedCourier: _selectedCourier,
              onChanged: (value) {
                setState(() {
                  _selectedCourier = value;
                });
              },
            ),
            const SizedBox(height: 16),
            BlocConsumer<ShipmentBloc, ShipmentState>(
              listener: (context, state) {
                if (state is ShipmentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: state is ShipmentLoaded
                          ? AnimatedPriceDisplay(
                              key: ValueKey<double>(state.rate),
                              rate: state.rate,
                            )
                          : const SizedBox(key: ValueKey('empty')),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _onCalculatePressed,
                      child: const Text(
                        'Calculate Price',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment Processed!')),
                        );
                      },
                      child: const Text(
                        'Pay',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
