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

  void removeChatPopover(OverlayEntry? chatPopoverEntry) {
    chatPopoverEntry?.remove();
  }

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

    // Add the user message to the state and set loading/sending states
    final allMessagesUser = List<Message>.from(state.messages)
      ..add(userMessage);

    allMessagesUser.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    emit(state.copyWith(
      messages: allMessagesUser,
      isLoading: true,
      isSending: true,
    ));

    try {
      // Fetch the bot's response
      final botMessages = await repository.getMessage(userQuestion);

      // Manually parse HTML content in the bot's response (if any)
      final parsedMessages = botMessages.map((message) {
        if (message.text.contains('<table')) {
          message.text = _parseHtmlTableWithBox(message.text);
        }
        return message;
      }).toList();

      // Add the parsed bot messages to the conversation
      final allMessages = List<Message>.from(allMessagesUser)
        ..addAll(parsedMessages);

      // Sorting the messages after both user and bot responses are added
      allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Update the state with the combined list of messages
      emit(state.copyWith(
        messages: allMessages,
        isLoading: false,
        isSending: false,
      ));
    } catch (e) {
      // Handle error and update the state
      emit(state.copyWith(
        messages: state.messages,
        isLoading: false,
        isSending: false,
        error: e.toString(),
      ));
    }
  }

  // Method to manually parse the HTML table content without using 'html' package
  String _parseHtmlTableWithBox(String htmlText) {
    final tableRegExp =
        RegExp(r'<tr>(.*?)</tr>', dotAll: true); // Regex to match table rows
    final rowRegExp =
        RegExp(r'<td>(.*?)</td>', dotAll: true); // Regex to match table cells

    StringBuffer parsedText = StringBuffer();

    final tableRows = tableRegExp.allMatches(htmlText);

    // Create the top border
    parsedText.writeln(
        '+${'-' * 80}+'); // Length of the dashes depends on the number of columns

    for (var row in tableRows) {
      final rowData = rowRegExp.allMatches(row.group(1) ?? '').map((match) {
        return match.group(1)?.trim() ?? ''; // Extract cell data
      }).join(' | ');

      // Add box line with separators between columns
      parsedText.writeln('| $rowData |');

      // Add a gap between rows
      parsedText.writeln(); // Blank line to create a gap between rows
    }

    // Create the bottom border
    parsedText.writeln('+${'-' * 80}+');

    return parsedText.toString().trim();
  }

  void filterCommands(String query) {
    final allCommands = [
      'Screen One',
      'Screen Two'
    ]; // Replace with your actual command list

    // Perform filtering based on the query
    final filtered = allCommands
        .where((command) => command.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Update the state with filtered commands
    emit(state.copyWith(
      messages: state.messages,
      isLoading: state.isLoading,
      isSending: state.isSending,
      filteredCommands: filtered,
    ));
  }
}
