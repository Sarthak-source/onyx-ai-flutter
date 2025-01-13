import 'package:onix_bot/features/chat_feature/domain/repositories/message_repository_impl.dart';
import 'package:onix_bot/features/chat_feature/presentation/widgets/message_bubble.dart';

class GetMessages {
  final MessageRepository repository;

  GetMessages(this.repository);

  Future<List<Message>> call(String question) async {
    return await repository.getMessage(question);
  }
}
