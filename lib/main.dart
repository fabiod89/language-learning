import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'language_selection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for async main
  await dotenv.load(fileName: ".env"); // Load environment variables
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LanguageSelectionScreen(),
    );
  }
}