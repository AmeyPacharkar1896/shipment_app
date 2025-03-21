import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipment_app/services/shipping_service.dart';

part "shipment_event.dart";
part "shipment_state.dart";

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final ShippingService shippingService;

  ShipmentBloc({ShippingService? shippingService})
      : shippingService = shippingService ?? ShippingService(),
        super(ShipmentInitial()) {
    on<ShippingRateRequested>(_onShippingRateRequested);
  }

  Future<void> _onShippingRateRequested(
      ShippingRateRequested event, Emitter<ShipmentState> emit) async {
    emit(ShipmentLoading());
    try {
      final rate = await shippingService.fetchShippingRate(
        pickupAddress: event.pickupAddress,
        deliveryAddress: event.deliveryAddress,
        courier: event.courier,
      );
      emit(ShipmentLoaded(rate: rate));
    } catch (e) {
      emit(ShipmentError(message: e.toString()));
    }
  }
}
