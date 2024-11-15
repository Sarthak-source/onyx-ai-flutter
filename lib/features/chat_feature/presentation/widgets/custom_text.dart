import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isMine;

  const CustomText(this.text, this.isMine, {super.key});

  @override
  Widget build(BuildContext context) {
    // Function to parse the message and apply bold, clickable styles
    List<TextSpan> parseText(String text) {
      final List<TextSpan> spans = [];
      final boldRegex = RegExp(r'\*\*(.*?)\*\*'); // For bold text between **
      //final linkRegex = RegExp(r'https?://[^\s]+'); // For links
      //final numberRegex = RegExp(r'\b\d+\b'); // For standalone numbers

      int startIndex = 0;
      final boldMatches = boldRegex.allMatches(text);

      // Process text segments for clickable links and numbers
      List<TextSpan> processTextSegments(String textSegment) {
        final List<TextSpan> spans = [];
        final linkRegex = RegExp(r'https?://[^\s]+'); // Match URLs
        final numberRegex = RegExp(r'\b\d+\b'); // Match numbers
        final startsRegex = RegExp(r'^/');

        int segmentStart = 0;
        final matches = [
          ...linkRegex.allMatches(textSegment),
          ...numberRegex.allMatches(textSegment),
          ...startsRegex.allMatches(textSegment),
        ];
        matches.sort(
            (a, b) => a.start.compareTo(b.start)); // Sort matches by position

        for (final match in matches) {
          // Add text before match as regular text
          if (match.start > segmentStart) {
            spans.add(TextSpan(
              text: textSegment.substring(segmentStart, match.start),
              style: TextStyle(
                  color: isMine ? Colors.white : Colors.black, fontSize: 14),
            ));
          }

          // Check if match is a link or a number
          final matchedText = match.group(0)!;
          if (linkRegex.hasMatch(matchedText)) {
            // Link text with tap to open URL
            spans.add(TextSpan(
              text: matchedText,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (await canLaunchUrl(Uri.tryParse(matchedText)!)) {
                    await launchUrl(Uri.tryParse(matchedText)!);
                  }
                },
            ));
          } else if (numberRegex.hasMatch(matchedText)) {
            // Number text with tap for potential action
            spans.add(TextSpan(
              text: matchedText,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Handle tap on number (could be to copy or perform another action)
                  log("Tapped on number: $matchedText");
                },
            ));
          }

          segmentStart = match.end;
        }

        // Add any remaining text after the last match
        if (segmentStart < textSegment.length) {
          spans.add(TextSpan(
            text: textSegment.substring(segmentStart),
            style: TextStyle(
                color: isMine ? Colors.white : Colors.black, fontSize: 14),
          ));
        }

        return spans;
      }

      for (final match in boldMatches) {
        if (match.start > startIndex) {
          // Process any sub-text for links and numbers
          spans.addAll(
              processTextSegments(text.substring(startIndex, match.start)));
        }

        // Add bold text
        spans.add(TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isMine ? Colors.white : Colors.black,
          ),
        ));

        startIndex = match.end;
      }

      // Process any remaining text after the last bold match
      if (startIndex < text.length) {
        spans.addAll(processTextSegments(text.substring(startIndex)));
      }

      return spans;
    }

    return RichText(
      text: TextSpan(children: parseText(text)),
    );
  }
}
