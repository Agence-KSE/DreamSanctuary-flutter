import 'package:flutter/material.dart';
import 'package:dream_sanctuary/data/Message.dart';

class oneMessage extends StatefulWidget {
  final List<Message> messages;

  oneMessage({Key? key, required this.messages}) : super(key: key);

  @override
  State<oneMessage> createState() => _oneMessageState();
}

class _oneMessageState extends State<oneMessage> {
  final _biggerFont = const TextStyle(fontSize: 18);
  final _lowerFont = const TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.messages[0].username),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.messages.length,
        itemBuilder: (context, i) {
          return ListTile(
            isThreeLine: true,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.messages[i].username,
                    textAlign: TextAlign.left,
                    style: _biggerFont,
                  ),
                ),
                Expanded(
                    child: Text(
                  widget.messages[i].timestamp,
                  textAlign: TextAlign.right,
                  style: _lowerFont,
                )),
              ],
            ),
            subtitle: Row(
              children: [
                Text(widget.messages[i].message),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
