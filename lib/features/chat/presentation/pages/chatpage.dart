import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../widgets/chatbubble.dart';
class ChatScreen extends StatefulWidget {
  final WebSocketChannel channel;
  const ChatScreen({super.key, required this.channel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool iscurrentUser = true;

  @override
  void initState() {
    super.initState();
    widget.channel.stream.listen(
          (message) {
        setState(() {
          iscurrentUser=true;
          _messages.add(message);

          print(' WebSocket Received Stream message : $message');
          print(' WebSocket Received Stream message length : '+ _messages.length.toString());
        });

        print(' WebSocket Received message: $message');
      },
      onError: (error) {
        print(' WebSocket WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
    print('WebSocket connection established');
  }

  @override
  void dispose() {
    widget.channel.sink.close(status.goingAway);
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
      setState(() {
        _messages.add("WebSocket You: ${_controller.text}");
      });

      print('WebSocket Sent message: ${_controller.text}');
      _controller.clear();
    }
  }
  final List<String> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ChatBubble( text: _messages[index],isCurrentUser: iscurrentUser,)
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message'),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),





      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chat",

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Channels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Profile"  ,
          ),
        ],
      ),
    );
  }
}

/*Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                ChatBubble(
                  text: 'How was the concert?',
                  isCurrentUser: false,
                ),
                ChatBubble(
                  text: 'Awesome! Next time you gotta come as well!',
                  isCurrentUser: true,
                ),
                ChatBubble(
                  text: 'Ok, when is the next date?',
                  isCurrentUser: false,
                ),
                ChatBubble(
                  text: 'They\'re playing on the 20th of November',
                  isCurrentUser: true,
                ),
                ChatBubble(
                  text: 'Let\'s do it!',
                  isCurrentUser: false,
                ),
              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.abc, color: Colors.grey,),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.camera_alt, color: Colors.grey,),

                  ],
                ),
              ),
              hintText: 'Type a message!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),*/



