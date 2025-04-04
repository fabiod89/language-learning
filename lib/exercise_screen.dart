import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'services/dictionary_service.dart';
import 'dictionary_screen.dart';
import 'constants/style_constants.dart';

class ExerciseScreen extends StatefulWidget {
  final List<String> sentences;
  final String targetLanguage;

  const ExerciseScreen({
    required this.sentences,
    required this.targetLanguage,
    Key? key,
  }) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final FlutterTts _tts = FlutterTts();
  int _currentIndex = 0;
  bool _showEnglish = false;
  double _speechRate = 0.5;

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  void _initializeTts() async {
    final langCode = _getLanguageCode();
    try {
      final hasLanguage = await _tts.isLanguageAvailable(langCode);
      if (hasLanguage) await _tts.setLanguage(langCode);
      await _tts.setSpeechRate(_speechRate);
    } catch (e) {
      debugPrint('TTS Error: $e');
    }
  }

  String _getLanguageCode() {
    switch (widget.targetLanguage.toLowerCase()) {
      case 'spanish': return 'es-ES';
      case 'french': return 'fr-FR';
      case 'italian': return 'it-IT';
      default: return 'en-US';
    }
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.sentences.length;
      _showEnglish = false;
    });
  }

  void _previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1) >= 0 
          ? _currentIndex - 1 
          : widget.sentences.length - 1;
      _showEnglish = false;
    });
  }

  Widget _buildSentence(String sentence) {
    final words = sentence.split(' ');
    return Wrap(
      children: words.map((word) => GestureDetector(
        onTap: () => _showWordDialog(word),
        child: Text(
          '$word ',
          style: kSentenceTextStyle.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      )).toList(),
    );
  }

  void _showWordDialog(String word) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add to Dictionary'),
        content: Text('Add "$word" to your study list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _saveWord(word);
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _saveWord(String word) async {
    try {
      await DictionaryService.saveWord(widget.targetLanguage, word);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added "$word" to dictionary!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: ${e.toString()}')),
      );
    }
  }

  Future<void> _speakSentence(String sentence) async {
    try {
      await _tts.speak(sentence);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Speech failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sentences.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('No sentences available')),
      );
    }

    final parts = widget.sentences[_currentIndex].split(' - ');
    final foreignSentence = parts[0];
    final englishTranslation = parts.length > 1 ? parts[1] : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.targetLanguage),
        actions: [
          IconButton(
            icon: Icon(Icons.library_books),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DictionaryScreen(
                  selectedLanguage: widget.targetLanguage,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Progress Indicator
            Text(
              'Sentence ${_currentIndex + 1} of ${widget.sentences.length}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Sentence Card
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSentence(foreignSentence),
                      SizedBox(height: 30),
                      if (_showEnglish)
                        Text(
                          englishTranslation,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Controls
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.volume_up, size: 32),
                      onPressed: () => _speakSentence(foreignSentence),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.translate, size: 32),
                      onPressed: () => setState(() => _showEnglish = !_showEnglish),
                    ),
                  ],
                ),
                Slider(
                  value: _speechRate,
                  min: 0.1,
                  max: 1.0,
                  divisions: 9,
                  label: 'Speed: ${_speechRate.toStringAsFixed(1)}',
                  onChanged: (value) async {
                    setState(() => _speechRate = value);
                    await _tts.setSpeechRate(value);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _previousCard,
                      child: Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: _nextCard,
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}