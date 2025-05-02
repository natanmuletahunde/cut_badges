import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Color purple = Color(0xFF6c5ce7);
  Color black = Color(0xFF191919);

  TextEditingController msgInputController = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    // TODO: implement initState
   socket = IO.io('http://localhost:4000',
    IO.OptionBuilder()
      .setTransports(['websocket']) 
      .disableAutoConnect()  
      .build());
    socket.connect();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        child: Column(
          children: [
            Expanded(flex: 9, child: Container(
              child: Container(
                child: ListView.builder( 
                  itemCount: 10,
                  itemBuilder:(context,index){
                  return MessageItem(sentByMe: true,);
                }),
              ),
            )),
            Expanded(
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
  
void sendMessage(String text) {
  var messageJson = {
    "message": text,
    "sentByMe": socket.id,
  };
  socket.emit('message', messageJson); // Send the full JSON
}

}
class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.sentByMe});
  final bool sentByMe;

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();
    final time = now.format(context); // Get current time in readable format

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: sentByMe ? Colors.purple : Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Hello',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
