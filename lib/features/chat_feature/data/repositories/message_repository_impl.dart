import 'package:onix_bot/features/chat_feature/data/datasources/message_remote_data_source.dart.dart';
import 'package:onix_bot/features/chat_feature/domain/repositories/message_repository_impl.dart';
import 'package:onix_bot/features/chat_feature/presentation/widgets/message_bubble.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Message>> getMessage(String question) async {
    return await remoteDataSource.getMessages(question);
  }
}
