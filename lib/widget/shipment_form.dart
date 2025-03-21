import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  String? _selectedCourier;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize fade-in animation for the entire form.
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

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AddressInputField(
              controller: _pickupController,
              label: 'Pickup Address',
              validator: validateAddress,
            ),
            const SizedBox(height: 16),
            AddressInputField(
              controller: _deliveryController,
              label: 'Delivery Address',
              validator: validateAddress,
            ),
            const SizedBox(height: 16),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedCourier != null) {
                          BlocProvider.of<ShipmentBloc>(context).add(
                            ShippingRateRequested(
                              pickupAddress: _pickupController.text,
                              deliveryAddress: _deliveryController.text,
                              courier: _selectedCourier!,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all fields.')),
                          );
                        }
                      },
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
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
