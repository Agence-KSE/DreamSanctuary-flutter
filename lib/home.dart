import 'dart:core';
import 'package:dream_sanctuary/assets/bottom_bar.dart';
import 'package:dream_sanctuary/one_message.dart';
import 'package:dream_sanctuary/profile/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:dream_sanctuary/data/Message.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Message> _messages = [
    Message(
        username: "Toto", timestamp: "Today", message: "Salut branquignole!"),
    Message(
        username: "Belle Delphine",
        timestamp: "Yesterday",
        message: "Welcome on my DS!")
  ];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _lowerFont = const TextStyle(fontSize: 12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Dream Sanctuary'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.message_sharp),
              tooltip: 'Messages',
              onPressed: _pushMessages,
            )
          ],
        ),
        body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'New post...',
            child: const Icon(Icons.add),
            elevation: 2.0,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          bottomNavigationBar:
              new DreamSanctuaryBottomBar(context, widget.username)
                  .createDreamSanctuaryBottomBar(),
          endDrawer: ProfileDrawer(widget.username).createProfileDrawer(),
        ));
  }

  void _pushMessages() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _messages.map((message) {
            return ListTile(
                isThreeLine: false,
                title: GestureDetector(
                  onTap: () {
                    // un message
                    Navigator.of(context)
                        .push(MaterialPageRoute<void>(builder: (context) {
                      return oneMessage(
                          // récupération des messages où username = celui qu'on a choisi
                          messages: _messages
                              .where((element) =>
                                  element.username == message.username)
                              .toList());
                    }));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.username,
                          textAlign: TextAlign.left,
                          style: _biggerFont,
                        ),
                      ),
                      Expanded(
                          child: Text(
                        message.timestamp,
                        textAlign: TextAlign.right,
                        style: _lowerFont,
                      )),
                    ],
                  ),
                  /* subtitle: Text(
                    message.message,
                    style: _lowerFont,
                  ),*/
                ));
          });
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Messages'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
