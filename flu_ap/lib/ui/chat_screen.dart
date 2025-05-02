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
    return  Scaffold(
      backgroundColor: black,
      body: Container(
        child: Column(
        
          children: [
            Expanded(flex:9,child:Container()),
            Expanded(child: 
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style:TextStyle(
                  color: Colors.white
                ),
                cursorColor: purple,
                controller:msgInputController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  suffixIcon: Container(
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                  )
                ),

              ),
            )
            
            )
          ],
        ),

      ),
    );
  }
}