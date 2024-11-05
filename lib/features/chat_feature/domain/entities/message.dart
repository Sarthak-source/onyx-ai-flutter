import 'package:onix_bot/features/chat_feature/presentation/widgets/message_bubble.dart';

class MessageModel extends Message {
  // Additional fields to match the API response
  final String question;
  final String answer;
  final String relevantChunk;

   MessageModel({
    required super.owner,
    required super.text,
    required this.question,
    required this.answer,
    required this.relevantChunk, required super.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      owner: json['owner'] == 'myself' ? MessageOwner.myself : MessageOwner.other,
      text: json['text'], // This might be replaced with a more relevant field
      question: json['question'],
      answer: json['answer'],
      relevantChunk: json['relevant_chunk'], sender: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': isMine ? 'myself' : 'other',
      'text': text,
      'question': question,
      'answer': answer,
      'relevant_chunk': relevantChunk,
    };
  }
}
