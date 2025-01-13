import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../presentation/widgets/message_bubble.dart';

abstract class MessageRemoteDataSource {
  Future<List<Message>> getMessages(String question);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final Dio dio;

  MessageRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Message>> getMessages(String question) async {
    try {
      final response = await dio.post(
        'https://apex.ultimatetek.in:6069/webhooks/rest/webhook',
        data: json.encode({'message': question}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        log(data.toString());

        // Ensure the response is a List and it's not empty
        if (data is List && data.isNotEmpty) {
          // Parse all the messages from the response
          List<Message> messages = [];
          for (var item in data) {
            final messageContent = item['text'] as String;
            messages.add(Message(
                text: messageContent,
                owner: MessageOwner.other,
                sender: ''));
          }
          return messages;
        } else {
          throw Exception('Invalid response format or empty response');
        }
      } else {
        throw Exception('Failed to fetch messages: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching messages: $e');
      throw Exception('Error fetching messages');
    }
  }
}
