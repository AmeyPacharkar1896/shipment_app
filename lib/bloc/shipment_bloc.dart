import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipment_app/models/shipping_model.dart';
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
      final rate = await shippingService.fetchShippingRate(event.shipmentRequest);
      emit(ShipmentLoaded(rate: rate));
    } catch (e) {
      emit(ShipmentError(message: e.toString()));
    }
  }
}
