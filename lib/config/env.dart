import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get geminiApiKey {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty || key == 'your_api_key_here') {
      return '';
    }
    return key;
  }
}
