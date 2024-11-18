import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_bot/features/chat_feature/presentation/cubits/messages_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isMine;
  final Color linkColor;
  final Color numberColor;

  const CustomText(
    this.text,
    this.isMine, {
    super.key,
    this.linkColor = Colors.blue,
    this.numberColor = const Color.fromARGB(255, 1, 171, 15),
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> parseText(String text) {
      final List<TextSpan> spans = [];
      final boldRegex =
          RegExp(r'\*\*(.*?)\*\*'); // Matches bold text (**bold**)
      final linkRegex = RegExp(r'https?://[^\s]+'); // Matches URLs
      final numberRegex = RegExp(r'#\d+'); // Matches numbers like #5676777

      int startIndex = 0;
      final boldMatches = boldRegex.allMatches(text);

      // Helper to parse non-bold text for links and numbers
      List<TextSpan> processSegment(String segment) {
        final List<TextSpan> segmentSpans = [];
        final matches = [
          ...linkRegex.allMatches(segment),
          ...numberRegex.allMatches(segment)
        ]..sort((a, b) => a.start.compareTo(b.start));

        int segmentStart = 0;

        for (final match in matches) {
          if (match.start > segmentStart) {
            segmentSpans.add(TextSpan(
              text: segment.substring(segmentStart, match.start),
              style: TextStyle(color: isMine ? Colors.white : Colors.black),
            ));
          }

          final matchedText = match.group(0)!;

          if (linkRegex.hasMatch(matchedText)) {
            // Link handling
            final uri = Uri.tryParse(matchedText);
            if (uri != null) {
              segmentSpans.add(TextSpan(
                text: matchedText,
                style: TextStyle(
                    color: linkColor, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
              ));
            }
          } else if (numberRegex.hasMatch(matchedText)) {
            // Number handling (e.g., #5676777)
            segmentSpans.add(TextSpan(
              text: matchedText,
              style: TextStyle(
                  color: numberColor, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context
                      .read<MessageCubit>()
                      .addMessageAndLoadResponse('Open order $matchedText');

                  // Custom action for the tapped number
                  log("Tapped on number: $matchedText");
                },
            ));
          }

          segmentStart = match.end;
        }

        if (segmentStart < segment.length) {
          segmentSpans.add(TextSpan(
            text: segment.substring(segmentStart),
            style: TextStyle(color: isMine ? Colors.white : Colors.black),
          ));
        }

        return segmentSpans;
      }

      for (final match in boldMatches) {
        if (match.start > startIndex) {
          spans.addAll(processSegment(text.substring(startIndex, match.start)));
        }

        spans.add(TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isMine ? Colors.white : Colors.black,
          ),
        ));

        startIndex = match.end;
      }

      if (startIndex < text.length) {
        spans.addAll(processSegment(text.substring(startIndex)));
      }

      return spans;
    }

    return BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
      return RichText(
        text: TextSpan(children: parseText(text)),
      );
    });
  }
}
