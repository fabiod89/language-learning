import 'package:flutter/material.dart';
import 'services/dictionary_service.dart';

class DictionaryScreen extends StatefulWidget {
  final String selectedLanguage;

  const DictionaryScreen({required this.selectedLanguage});

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  late Future<List<String>> _wordsFuture;

  @override
  void initState() {
    super.initState();
    _wordsFuture = DictionaryService.getWords(widget.selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Dictionary')),
      body: FutureBuilder<List<String>>(
        future: _wordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          final words = snapshot.data ?? [];
          
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(words[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteWord(words[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _deleteWord(String word) async {
    await DictionaryService.removeWord(widget.selectedLanguage, word);
    setState(() {
      _wordsFuture = DictionaryService.getWords(widget.selectedLanguage);
    });
  }
}