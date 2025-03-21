part of "shipment_bloc.dart";

abstract class ShipmentEvent extends Equatable {
  const ShipmentEvent();

  @override
  List<Object> get props => [];
}

class ShippingRateRequested extends ShipmentEvent {
  final String pickupAddress;
  final String deliveryAddress;
  final String courier;

  const ShippingRateRequested({
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.courier,
  });

  @override
  List<Object> get props => [pickupAddress, deliveryAddress, courier];
}
