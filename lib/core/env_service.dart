import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  static String get shippoTestKey => dotenv.get('SHIPPO_TEST_KEY');
}
