import 'package:flutter/material.dart';
import 'package:shipment_app/application.dart';
import 'package:shipment_app/core/env_service.dart';

Future<void> main() async {
  await EnvService.init();
  runApp(const Application());
}
