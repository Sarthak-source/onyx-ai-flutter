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

        return Message(
          text: data['answer']['output_text'],
          owner: MessageOwner.other,
          sender: '',
        );
      } else {
        // Return a Message with an error description
        return Message(
          text: '😱',
          owner: MessageOwner.other,
          sender: '',
          error: 'Connection Timeout, Send Again.',
        );
      }
    } catch (e) {
      log('Error: $e');
      // Return a Message with an error description
      return Message(
        text: '😱',
        owner: MessageOwner.other,
        sender: '',
        error: 'Connection Timeout, Send Again.',
      );
    }
  }
}
