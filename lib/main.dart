import 'package:aynachatx/features/auth/presentation/pages/login_page.dart';
import 'package:aynachatx/features/auth/presentation/pages/signup_page.dart';
import 'package:aynachatx/features/chat/presentation/pages/sessionspage.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'core/theme/theme.dart';

import 'features/chat/presentation/pages/chatpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayna Chat',
      theme: AppTheme.darkThemeMode,
      home: SessionsPage(),
      //home: ChatScreen(channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),),

    );
  }
}



