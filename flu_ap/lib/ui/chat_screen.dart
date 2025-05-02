import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Color purple = Color(0xFF6c5ce7);
  Color black = Color(0xFF191919);

  TextEditingController msgInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          children: [
            // Message list
            Expanded(
              flex: 9,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MessageItem(sentByMe: index % 2 == 0); // alternating messages
                },
              ),
            ),
            // Input field
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: purple,
                controller: msgInputController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        sendMessage(msgInputController.text);
                        msgInputController.clear();
                      },
                      icon: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) {
    // Placeholder for sending messages
    print('Sending: $text');
  }
}

class MessageItem extends StatelessWidget {
  final bool sentByMe;

  const MessageItem({super.key, required this.sentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: sentByMe ? Colors.purple : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          sentByMe ? "Hello from me!" : "Hello from them!",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
