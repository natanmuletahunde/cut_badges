import 'package:flu_ap/controller/chat_controller.dart';
import 'package:flu_ap/model/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
  ChatController chatController = ChatController();

  @override
  void initState() {
    super.initState();
    // Replace with your machine's IP
    socket = IO.io('http://10.240.212.139:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setSocketListeners();

    socket.onConnect((_) {
      print("Connected to socket server");
    });

    socket.onDisconnect((_) => print("Disconnected"));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
        Expanded(child: Container(
          child: Text('Connected user ${chatController.connectedUser}',),
        ) ),
          Expanded(

            flex: 9,
            child: Obx(
              ()=> ListView.builder(
                itemCount: chatController.chatMessages.length,
                itemBuilder: (context, index) {
                  var  currentItem = chatController.chatMessages[index];
                return MessageItem(
                  sentByMe:currentItem.sentByMe==socket.id,
                  message: currentItem.message,);
                },
              ),
            ),
          ),
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
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        sendMessage(msgInputController.text);
                        msgInputController.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void sendMessage(String text) {
    if (text.trim().isEmpty || !socket.connected) return;

    var messageJson = {
      "message": text,
      "sentByMe": socket.id,
    };
    socket.emit('message', messageJson);
      chatController.chatMessages.add(Message.fromJson(messageJson));
  }
  void setSocketListeners() {
    socket.on('message-received', (data){
      print(data);
      chatController.chatMessages.add(Message.fromJson(data));
    });
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.sentByMe, required this.message});
  final bool sentByMe;
  final String message ;

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();
    final time = now.format(context);

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
              message,
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
