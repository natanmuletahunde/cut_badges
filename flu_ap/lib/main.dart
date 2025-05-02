import 'package:flu_ap/ui/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOcket Chat App',
      theme: ThemeData(
       primarySwatch: Colors.blue
            ),
      home: const ChatScreen(),
    );
  }
}



