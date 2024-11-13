import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isMine;

  const CustomText(this.text, this.isMine, {super.key});

  @override
  Widget build(BuildContext context) {
    // Function to parse the message and apply bold styles
    List<TextSpan> parseText(String text) {
      final List<TextSpan> spans = [];
      final regex = RegExp(r'\*\*(.*?)\*\*'); // Regex to find text between **

      int startIndex = 0;
      final matches = regex.allMatches(text);

      for (final match in matches) {
        // Add the text before the match as normal
        if (match.start > startIndex) {
          spans.add(TextSpan(
            text: text.substring(startIndex, match.start),
            style: TextStyle(
                color: isMine ? Colors.white : Colors.black,fontSize: 14), // Regular style
          ));
        }

        // Add the matched text as bold
        spans.add(TextSpan(
          text: match.group(1), // Get the bold text without **
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isMine ? Colors.white : Colors.black), // Bold style
        ));

        // Update the startIndex for the next segment
        startIndex = match.end;
      }

      // Add any remaining text after the last match
      if (startIndex < text.length) {
        spans.add(TextSpan(
          text: text.substring(startIndex),
          style: TextStyle(
              color: isMine ? Colors.white : Colors.black,fontSize: 14), // Regular style
        ));
      }

      return spans;
    }

    return RichText(
      text: TextSpan(children: parseText(text)),
    );
  }
}
