part of "shipment_bloc.dart";

abstract class ShipmentEvent extends Equatable {
  const ShipmentEvent();

  @override
  List<Object> get props => [];
}

class ShippingRateRequested extends ShipmentEvent {
  final ShippingModel shipmentRequest;

  const ShippingRateRequested({required this.shipmentRequest});

  @override
  List<Object> get props => [shipmentRequest];
}
