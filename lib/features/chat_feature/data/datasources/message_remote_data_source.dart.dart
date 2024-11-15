import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../presentation/widgets/message_bubble.dart';

abstract class MessageRemoteDataSource {
  Future<Message> getMessage(String question);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final Dio dio;

  MessageRemoteDataSourceImpl({required this.dio});

  @override
  Future<Message> getMessage(String question) async {
    try {
      final response = await dio.post(
        'https://onix-bot.onrender.com/ask',
        data: json.encode(
            {'question': question}), // Pass the question in the request body
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        log(data.toString());

        // Check intent type
        final intent = data['intent']['intent'];

        // Handle different intents
        if (intent == 'open_screen_command') {
          // Handle navigation intent
          final route = data['intent']['route'];
          final message = data['intent']['message'];

          log('Navigation command detected, route: $route');

          return Message(
            text: "$message $route", // Placeholder message
            owner: MessageOwner.other,
            sender: '',
            route: route, // Pass route to be used in Flutter navigation
          );
        } else if (intent == 'view_order_details') {
          // Handle order details intent
          final orderNumber = data['intent']['order_number'];
          final orderDetails = data['answer'];
          final options = data['intent']['option'];
          log('Order details for order number: $orderNumber');

          return Message(
            text: orderDetails, // The detailed order information
            owner: MessageOwner.other,
            sender: '',
            options: options
          );
        } else if (intent == 'update_order_status') {
          // Handle order status update intent
          final status = data['intent']['status'];
          final updateStatusMessage = data['answer'];
          log('Order status updated to: $status');

          return Message(
            text: updateStatusMessage, // The status update message
            owner: MessageOwner.other,
            sender: '',
          );
        } else if (intent == 'view_previous_orders') {
          final updatePevOrderMessage = data['answer'];
          // Handle conversation end intent
          return Message(
            text: updatePevOrderMessage,
            owner: MessageOwner.other,
            sender: '',
          );
        } else if (intent == 'select_intent_command') {
          final selectIntent = data['answer'];
          final options = data['intent']['options'];
          // Handle conversation end intent
          return Message(
            text: selectIntent,
            owner: MessageOwner.other,
            sender: '',
            options: options
          );
        } else if (intent == 'end_conversation') {
          // Handle conversation end intent
          return Message(
            text:
                'Thank you for chatting! If you have more questions, feel free to ask.',
            owner: MessageOwner.other,
            sender: '',
          );
        } else {
          // Handle normal question response
          return Message(
            text: data['answer']['output_text'],
            owner: MessageOwner.other,
            sender: '',
          );
        }
      } else {
        return Message(
          text: '😱',
          owner: MessageOwner.other,
          sender: '',
          error: 'Connection Timeout, Send Again.',
        );
      }
    } catch (e) {
      log('Error: $e');
      return Message(
        text: '😱',
        owner: MessageOwner.other,
        sender: '',
        error: 'Connection Timeout, Send Again.',
      );
    }
  }
}
