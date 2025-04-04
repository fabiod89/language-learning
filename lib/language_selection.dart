import 'package:flutter/material.dart';
import 'criteria_input.dart';
// Add other specific imports as needed

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Language')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLanguageButton(context, 'Spanish'),
            _buildLanguageButton(context, 'French'),
            _buildLanguageButton(context, 'Italian'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, String language) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _navigateToCriteria(context, language),
        style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
        child: Text(language),
      ),
    );
  }

  void _navigateToCriteria(BuildContext context, String language) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CriteriaInputScreen(selectedLanguage: language),
      ),
    );
  }
}