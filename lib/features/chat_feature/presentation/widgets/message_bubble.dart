import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:onix_bot/core/style/app_colors.dart';

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.child,
  });

  final Message message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
        !message.isMine ? Alignment.topLeft : Alignment.topRight;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: message.isMine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: message.isMine
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isMine) ...[
                    CircleAvatar(
                      backgroundColor: chatBlue,
                      radius:
                          16.0, // Adjust the radius to make the avatar smaller
                      child: ClipOval(
                        child: SizedBox(
                          width: 26.0, // Set a specific width
                          height: 26.0, // Set a specific height
                          child: Image.asset(
                            'assets/onyx-logo.png', // Replace with actual image URL
                            fit: BoxFit
                                .cover, // Ensure the image covers the CircleAvatar
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 8.0), // Space between avatar and message bubble
                  ],
                  Flexible(child: backgroundBubble()),
                ],
              ),
              if (message.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 15),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          message.error!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect backgroundBubble() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      child: BubbleBackground(
        colors: message.isMine
            ? [chatBlue, chatBlue]
            : [Colors.white, Colors.white],
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 18.0,
            color: message.isMine ? Colors.white : Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    super.key,
    required this.colors,
    this.child,
  });

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context),
        bubbleContext: context,
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
        _bubbleContext = bubbleContext,
        _colors = colors,
        super(repaint: scrollable.position);

  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;
  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);

    // Draw shadow for elevation
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2) // Shadow color
      ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal, 4.0); // Blur effect for soft shadow
    final rect = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, const Radius.circular(12.0)), // Rounded corners for shadow
      shadowPaint,
    );

    // Draw the gradient bubble
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        [0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, const Radius.circular(12.0)), // Same rounded corners for bubble
      paint,
    );
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._bubbleContext != _bubbleContext ||
        oldDelegate._colors != _colors;
  }
}

enum MessageOwner { myself, other }

@immutable
class Message {
  Message({
    required this.owner,
    required this.text,
    required this.sender,
    this.error, // Add this optional error message field
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final MessageOwner owner;
  final String text;
  final String sender;
  final String? error; // Error message, if any
  final DateTime timestamp;

  bool get isMine => owner == MessageOwner.myself;
}
