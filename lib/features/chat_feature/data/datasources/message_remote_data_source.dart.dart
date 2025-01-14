import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../presentation/widgets/message_bubble.dart';

abstract class MessageRemoteDataSource {
  Future<List<Message>> getMessages(String question);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final Dio dio;

  MessageRemoteDataSourceImpl({required this.dio});

  String generateSessionId() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      6,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  @override
  Future<List<Message>> getMessages(String question) async {
    try {
      String sessId = generateSessionId();
      final response = await dio.post(
        'https://apex.ultimatetek.in:6069/webhooks/rest/webhook',
        data: json.encode({
          'message': question,
          'metadata': {
            'sessId': sessId,
          },
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (kDebugMode) {
          print(data.toString());
        }

        // Ensure the response is a List and it's not empty
        if (data is List && data.isNotEmpty) {
          // Parse all the messages from the response
          List<Message> messages = [];
          for (var item in data.reversed) {
            final messageContent = item['text'] as String;
            messages.add(Message(
              text: messageContent,
              owner: MessageOwner.other,
              sender: '',
            ));
          }

          messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

          return messages;
        } else {
          throw Exception('Invalid response format or empty response');
        }
      } else {
        throw Exception('Failed to fetch messages: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching messages: $e');
      }
      throw Exception('Error fetching messages');
    }
  }
}
