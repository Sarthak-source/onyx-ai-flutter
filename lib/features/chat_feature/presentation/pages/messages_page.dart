import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_bot/core/responsive/responsive_ext.dart';
import 'package:onix_bot/core/style/app_colors.dart';
import 'package:onix_bot/features/chat_feature/data/datasources/message_remote_data_source.dart.dart';
import 'package:onix_bot/features/chat_feature/data/repositories/message_repository_impl.dart';
import 'package:onix_bot/features/chat_feature/presentation/cubits/messages_cubit.dart';
import 'package:onix_bot/features/chat_feature/presentation/widgets/custom_text.dart';
import 'package:onix_bot/features/chat_feature/presentation/widgets/message_bubble.dart';
import 'package:onix_bot/features/first_feature/presentation/pages/first_page.dart';
import 'package:onix_bot/features/second_feature/presentation/pages/second_page.dart';

class OnixBotChatPage extends StatelessWidget {
  const OnixBotChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();
    OverlayEntry? commandPopoverEntry;
    OverlayEntry? chatPopoverEntry;

    focusNode.addListener(() {
      if (focusNode.hasFocus && controller.text.startsWith('/')) {
        _showCommandPopover(
            context, commandPopoverEntry, chatPopoverEntry, controller.text);
      }
    });

    controller.addListener(() {
      final text = controller.text;
      if (text.startsWith('/')) {
        context.read<MessageCubit>().filterCommands(text.substring(1));
        _showCommandPopover(
            context, commandPopoverEntry, chatPopoverEntry, text);
      } else {
        _removeCommandPopover(commandPopoverEntry);
      }
    });

    return BlocProvider(
      create: (context) {
        final dio = Dio();
        final remoteDataSource = MessageRemoteDataSourceImpl(dio: dio);
        final repository =
            MessageRepositoryImpl(remoteDataSource: remoteDataSource);
        return MessageCubit(repository: repository);
      },
      child: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: chatBlue,
              shape: const CircleBorder(),
              onPressed: () {
                if (state.isChatPopoverOpen) {
                  _removeChatPopover(chatPopoverEntry);
                  context.read<MessageCubit>().popOverClose(false);
                } else {
                  _showChatPopover(
                      context, chatPopoverEntry, controller, focusNode);
                  context.read<MessageCubit>().popOverClose(true);
                }
              },
              child: Image.asset('assets/onyx-logo.png', width: 40, height: 40),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: const Center(child: Text('Chat UI Placeholder')),
            //bottomSheet: _chatInputField(context, controller, focusNode, state),
          );
        },
      ),
    );
  }

  Widget _chatInputField(BuildContext context, TextEditingController controller,
      FocusNode focusNode, MessageState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Material(
        elevation: 0.5,
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onSubmitted: state.isSending
              ? null
              : (value) {
                  final question = controller.text;
                  if (question.isNotEmpty) {
                    context
                        .read<MessageCubit>()
                        .addMessageAndLoadResponse(question);
                    controller.clear();
                    focusNode.requestFocus();
                  }
                },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200], // Background color for the text field
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 22.0),
            suffixIcon: IconButton(
              icon: state.isSending
                  ? SizedBox(
                      width: 24,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(chatBlue),
                      ),
                    )
                  : Icon(Icons.send, color: chatBlue),
              onPressed: state.isSending
                  ? null
                  : () {
                      final question = controller.text;
                      if (question.isNotEmpty) {
                        context
                            .read<MessageCubit>()
                            .addMessageAndLoadResponse(question);
                        controller.clear();
                        focusNode.requestFocus();
                      }
                    },
            ),
            hintText:
                state.isSending ? 'Waiting for response' : 'Write a message...',
            hintStyle:
                TextStyle(color: Colors.grey[500]), // Lighter color for hint
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // More rounded corners
              borderSide: BorderSide.none, // No border outline
            ),
          ),
        ),
      ),
    );
  }

  void _showCommandPopover(
      BuildContext context,
      OverlayEntry? commandPopoverEntry,
      OverlayEntry? chatPopoverEntry,
      String text) {
    if (commandPopoverEntry != null) return;

    final overlay = Overlay.of(context);
    commandPopoverEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).size.height - 310,
          left: context.isDesktop
              ? (context.width * 0.70)
              : (context.width * 0.1),
          right: 20,
          child: Material(
            elevation: 10,
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: BlocBuilder<MessageCubit, MessageState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Type your command here...',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.filteredCommands.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              state.filteredCommands[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              log("Navigating to ${state.filteredCommands[index]}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    if (state.filteredCommands[index] ==
                                        'Screen One') {
                                      return const FirstPage();
                                    } else {
                                      return const SecondPage();
                                    }
                                  },
                                ),
                              );
                              _removeCommandPopover(commandPopoverEntry);
                              //_removeChatPopover(chatPopoverEntry);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    overlay.insert(commandPopoverEntry);
  }

  void _removeCommandPopover(OverlayEntry? commandPopoverEntry) {
    commandPopoverEntry?.remove();
  }

  void _showChatPopover(BuildContext context, OverlayEntry? chatPopoverEntry,
      controller, focusNode) {
    if (chatPopoverEntry != null) return;

    final overlay = Overlay.of(context);
    chatPopoverEntry = OverlayEntry(
      builder: (context) {
        return BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
          return Positioned(
            top: MediaQuery.of(context).size.height / 2 - 320,
            left: context.isDesktop
                ? (context.width * 0.70)
                : (context.width * 0.1),
            right: 20,
            child: Material(
              //color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  // Close the popover when tapping outside
                  //_removeChatPopover(chatPopoverEntry);
                },
                child: !state.showChat
                    ? chatWelcomeWidget(chatPopoverEntry)
                    : chatContainer(
                        context, controller, focusNode, chatPopoverEntry),
              ),
            ),
          );
        });
      },
    );
    overlay.insert(chatPopoverEntry);
  }

  Container chatContainer(
      BuildContext context, controller, focusNode, chatPopoverEntry) {
    return Container(
      decoration: BoxDecoration(
        color: chatLightGray,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: _chatBody(context, controller, focusNode, chatPopoverEntry),
    );
  }

  Row chatHeader() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: chatBlue,
          radius: 20,
          child: Image.asset('assets/onyx-logo.png', width: 40, height: 40),
        ),
        const SizedBox(width: 10),
        const Text(
          "ChatBot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget chatWelcomeWidget(chatPopoverEntry) {
    return BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
      return Center(
        child: Container(
          height: 550, // Adjust width as needed
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            //color: Colors.white,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // White
                Color(0xFFDBE9FF), // Light blue
              ],
            ),

            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Header section with logo and title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  chatHeader(),
                  InkWell(
                      onTap: () {
                        _removeChatPopover(chatPopoverEntry);
                      },
                      child: const Icon(Icons.remove))
                ],
              ),
              const SizedBox(height: 20),

              // Ultimate Solutions logo
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://i.imgur.com/6yhSzbH.png', // Replace with your logo path
                    height: 40,
                  ),
                  const SizedBox(height: 20),

                  // Main greeting text
                  const Text(
                    "Hello, How can we help you today?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Let me know if you have any questions!",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Chat button
                  ElevatedButton(
                    onPressed: () {
                      context.read<MessageCubit>().chatSwitch();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: chatBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(
                          double.infinity, 60), // Full width and custom height
                      alignment: Alignment
                          .centerLeft, // Aligns the content of the button to the left
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Aligns the icon and text to the left
                      children: [
                        // Space between icon and text
                        const Text(
                          "Chat With Us",
                          style: TextStyle(color: Colors.white),
                        ),
                        //const SizedBox(width: 8),
                        InkWell(
                            onTap: () {
                              context.read<MessageCubit>().chatSwitch();
                            },
                            child: const Icon(Icons.arrow_forward,
                                color: Colors.white)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Documentation link
                  GestureDetector(
                      onTap: () {
                        // Add link functionality here
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'View Our ',
                              style: TextStyle(
                                color: Colors
                                    .black, // Default color for "View Our"
                              ),
                            ),
                            TextSpan(
                              text: 'Documentation',
                              style: TextStyle(
                                color:
                                    chatBlue, // Blue color for "Documentation"
                                decoration: TextDecoration.none, // No underline
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),

              const SizedBox(height: 40),

              // Footer text
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Powered by ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Ultimate Solutions',
                      style: TextStyle(
                        color: Colors.grey,

                        fontSize: 12,
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center, // Center align
              )
            ],
          ),
        ),
      );
    });
  }

  void _removeChatPopover(OverlayEntry? chatPopoverEntry) {
    chatPopoverEntry?.remove();
  }

  Widget _chatBody(
      BuildContext context, controller, focusNode, chatPopoverEntry) {
    //OverlayEntry? chatPopoverEntry;
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        if (state.isLoading && state.messages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          log(state.error.toString());
          return Center(child: Text('Error: ${state.error}'));
        }

        return Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), // Adjust the value as needed
                  topRight: Radius.circular(12), // Adjust the value as needed
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          context.read<MessageCubit>().chatSwitch();
                        },
                        child: const Icon(Icons.arrow_back)),
                    chatHeader(),
                    InkWell(
                        onTap: () {
                          _removeChatPopover(chatPopoverEntry);
                        },
                        child: const Icon(Icons.remove))
                  ],
                ),
              ),
            ),
            state.messages.isEmpty
                ? const SizedBox(
                    height: 450,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome to Onyx AI",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Type your question or '/' for commands",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 450,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      reverse: true,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return MessageBubble(
                          message: message,
                          child: CustomText(message.text, message.isMine),
                        );
                      },
                    ),
                  ),
            _chatInputField(context, controller, focusNode, state),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Powered by ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Ultimate Solutions',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center, // Center align
              ),
            )
          ],
        );
      },
    );
  }
}
