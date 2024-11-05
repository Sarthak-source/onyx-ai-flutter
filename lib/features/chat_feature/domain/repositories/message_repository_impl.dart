import 'package:onix_bot/features/chat_feature/presentation/widgets/message_bubble.dart';

abstract class MessageRepository {
  Future<Message> getMessage(String question);
}
