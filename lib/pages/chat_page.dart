import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  int times = 0;

  ScrollController _scrollController = ScrollController();

  void example() {
    setState(() {
      _messages.add({
        'sender': 'EcoFriend',
        'message':
            "Hello! I was looking at your purchase history and noticed a couple improvements you can make.\n\nPlastic Water Bottles\nRecommendation: Buy a stainless steel water bottle from Amazon for only 2.99\nStainless steel water bottles are superior to plastic counterparts for the environment due to their reusability, reducing single-use plastic waste, and their extended lifespan, leading to fewer bottles ending up in landfills or oceans.\n\nIncandescent Light Bulbs\nRecommendation: Buy LED Light Bulbs from Ebay for \$5.99\nLED light bulbs are more energy-efficient, leading to reduced electricity consumption and lower greenhouse gas emissions from power plants.\nThey can last up to 25 times longer, which means fewer bulbs need to be manufactured, transported, and disposed of, reducing overall waste and resource consumption."
      });
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({
        'sender': 'User',
        'message': message,
      });
    });

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/cohere'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      String botMessage = responseBody['response'];

      setState(() {
        _messages.add({
          'sender': 'EcoFriend',
          'message': botMessage,
        });
      });
    } else {
      setState(() {
        _messages.add({
          'sender': 'EcoFriend',
          'message': 'Error occurred. Please try again.',
        });
      });
    }

    _messageController.clear();

    // Scroll to the bottom after adding a new message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildMessageBubble(BuildContext context, int index) {
    final message = _messages[index];
    final String sender = message['sender'];
    final String text = message['message'];
    final isUserMessage = sender == 'User';

    final bubbleAlign =
        isUserMessage ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor =
        isUserMessage ? Color.fromARGB(255, 13, 125, 54) : Colors.grey[300];
    final textColor = isUserMessage ? Colors.white : Colors.black;

    return Align(
      alignment: bubbleAlign,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    times++;
    if (times == 1) {
      example();
    }
    return Scaffold(
      appBar: AppBar(
        title: Container(
            child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('EcoFriend'),
            TypewriterAnimatedText('Spending Sustainably'),
          ],
        )),
        backgroundColor: Color.fromARGB(255, 13, 125, 54),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessageBubble(context, index);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90.0),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
