import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SentenceGenerator {
  static final _apiKey = dotenv.env['GEMINI_API_KEY']!;

  static Future<List<String>> generateSentences(Map<String, String> criteria) async {
    final model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 1,
        topP: 0.95,
        topK: 40,
        maxOutputTokens: 8192,
      ),
    );

    const exampleResponse = '''
---
Bonjour, comment allez-vous? - Hello, how are you?
Où est la bibliothèque? - Where is the library?
Je m'appelle Marie. - My name is Marie.
---
''';

    final prompt = '''
Generate 10 distinct language learning sentences in ${criteria['language']} for a ${criteria['level']} learner.
Topics: ${criteria['topics']}
Focus words: ${criteria['dictionary']}

Format EXACTLY like this between --- markers:
$exampleResponse
Include ONLY the numbered sentences with translations.
''';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return _parseResponse(response.text ?? '');
    } catch (e) {
      throw Exception('Failed to generate sentences: $e');
    }
  }

  static List<String> _parseResponse(String response) {
    final pattern = RegExp(r'^\s*([^-\n]+?)\s*-\s*([^\n]+)\s*$', multiLine: true);
    final matches = pattern.allMatches(response);
    
    return matches.map((match) => '${match.group(1)} - ${match.group(2)}').toList();
  }
}