import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_bot/features/chat_feature/domain/repositories/message_repository_impl.dart';
import 'package:onix_bot/features/chat_feature/presentation/widgets/message_bubble.dart';

class MessageState {
  final List<Message> messages;
  final bool isLoading;
  final bool isSending;
  final String? error;
  final bool showChat;
  final bool isChatPopoverOpen;
  final List<String> filteredCommands;

  MessageState({
    this.messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.showChat = false,
    this.isChatPopoverOpen = false,
    this.error,
    this.filteredCommands = const [],
  });

  MessageState copyWith({
    List<Message>? messages,
    bool? isLoading,
    bool? isSending,
    String? error,
    bool? showChat,
    bool? isChatPopoverOpen,
    List<String>? filteredCommands,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      error: error ?? this.error,
      showChat: showChat ?? this.showChat,
      isChatPopoverOpen: isChatPopoverOpen ?? this.isChatPopoverOpen,
      filteredCommands: filteredCommands ?? this.filteredCommands,
    );
  }
}

class MessageCubit extends Cubit<MessageState> {
  final MessageRepository repository;
  final TextEditingController controller = TextEditingController();

  MessageCubit({required this.repository}) : super(MessageState());

  void chatSwitch() {
    emit(state.copyWith(showChat: !state.showChat));
  }

  void popOverClose(bool openOrClose) {
    emit(state.copyWith(isChatPopoverOpen: openOrClose));
  }

  Future<void> addMessageAndLoadResponse(String userQuestion) async {
    final userMessage = Message(
      text: userQuestion,
      sender: "user",
      owner: MessageOwner.myself,
    );

    final allMessagesUser = [...state.messages, userMessage];
    allMessagesUser.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    emit(state.copyWith(
      messages: allMessagesUser,
      isLoading: true,
      isSending: true,
    ));

    try {
      final botMessage = await repository.getMessage(userQuestion);
      final allMessages = [...allMessagesUser, botMessage];
      allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      emit(state.copyWith(
        messages: allMessages,
        isLoading: false,
        isSending: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        messages: [...state.messages],
        isLoading: false,
        isSending: false,
        error: e.toString(),
      ));
    }
  }

  void filterCommands(String query) {
    final allCommands = [
      'Screen One',
      'Screen Two'
    ]; // Replace with your command list
    final filtered = allCommands
        .where((command) => command.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(
      messages: state.messages,
      isLoading: state.isLoading,
      isSending: state.isSending,
      filteredCommands: filtered,
    ));
  }
}
