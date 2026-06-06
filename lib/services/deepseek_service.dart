import 'dart:convert';
import 'package:http/http.dart' as http;

class DeepSeekService {
  //Hardcoded API Key from Deepseek
  static const String _apiKey = 'sk-152cf2a6091f4b93a197d5edd1ed2903';
  static const String _baseUrl = 'https://api.deepseek.com/v1/chat/completions';

  static final List<Map<String, String>> _conversationHistory = [
    {
      'role': 'system',
      'content':
          'You are a helpful, friendly AI assistant. Answer concisely and clearly.'
    }
  ];

  static void clearHistory() {
    _conversationHistory.removeRange(1, _conversationHistory.length);
  }

  static Future<String> sendMessage(String userMessage) async {
    _conversationHistory.add({'role': 'user', 'content': userMessage});

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': _conversationHistory,
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'] as String;
        _conversationHistory.add({'role': 'assistant', 'content': reply});
        return reply;
      } else {
        final error = jsonDecode(response.body);
        return 'Error: ${error['error']['message'] ?? 'Unknown error'}';
      }
    } catch (e) {
      return 'Failed to connect: ${e.toString()}';
    }
  }
}
