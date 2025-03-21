part of "shipment_bloc.dart";

abstract class ShipmentState extends Equatable {
  const ShipmentState();

  @override
  List<Object> get props => [];
}

class ShipmentInitial extends ShipmentState {}

class ShipmentLoading extends ShipmentState {}

class ShipmentLoaded extends ShipmentState {
  final double rate;

  const ShipmentLoaded({required this.rate});

  @override
  List<Object> get props => [rate];
}

class ShipmentError extends ShipmentState {
  final String message;

  const ShipmentError({required this.message});

  @override
  List<Object> get props => [message];
}
