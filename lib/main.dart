import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onix_bot/features/chat_feature/data/datasources/message_remote_data_source.dart.dart';
import 'package:onix_bot/features/chat_feature/data/repositories/message_repository_impl.dart';
import 'package:onix_bot/features/chat_feature/presentation/cubits/messages_cubit.dart';
import 'package:onix_bot/features/chat_feature/presentation/pages/messages_page.dart';

void main() {
  runApp(const App(home: OnixBotChatPage()));
}

@immutable
class App extends StatelessWidget {
  const App({super.key, this.home});

  final Widget? home;

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final remoteDataSource = MessageRemoteDataSourceImpl(dio: dio);
    final repository =
        MessageRepositoryImpl(remoteDataSource: remoteDataSource);
    return BlocProvider(
      create: (context) => MessageCubit(repository: repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Chat',
        theme: ThemeData.light(useMaterial3: true),
        home: home,
      ),
    );
  }
}
