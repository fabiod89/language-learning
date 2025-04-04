import 'package:flutter/material.dart';

// Color Palette
const kPrimaryColor = Color(0xFF6C63FF);
const kSecondaryColor = Color(0xFFF5F5F7);
const kTextColor = Color(0xFF333333);
const kCardBackground = Colors.white;
const kTranslationBg = Color(0xFFF0F0FF);

// Text Styles
const kTitleTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  letterSpacing: 0.5,
);

const kBodyTextStyle = TextStyle(
  fontSize: 16,
  color: kTextColor,
  height: 1.5,
);

const kSentenceTextStyle = TextStyle(
  fontSize: 22,  // Larger for better readability
  color: kPrimaryColor,
  height: 1.6,
  fontWeight: FontWeight.w500,
);

const kTranslationTextStyle = TextStyle(
  fontSize: 18,
  color: kTextColor,
  fontStyle: FontStyle.italic,
  height: 1.5,
);

// Button Styles
final kPrimaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
);

final kSecondaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.white,
  foregroundColor: kPrimaryColor,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: const BorderSide(color: kPrimaryColor, width: 1.5),
  ),
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
);

// Layout Constants
const kDefaultPadding = 24.0;
const kCardBorderRadius = 16.0;
const kElementSpacing = 20.0;

// Card Style
final kCardDecoration = BoxDecoration(
  color: kCardBackground,
  borderRadius: BorderRadius.circular(kCardBorderRadius),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ],
);

// Speed Control Style
const kSpeedControlTextStyle = TextStyle(
  fontSize: 14,
  color: kTextColor,
  fontWeight: FontWeight.w500,
);