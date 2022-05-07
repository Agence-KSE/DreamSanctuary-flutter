import 'dart:developer';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:dream_sanctuary/data/Message.dart';
import 'package:dream_sanctuary/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.userName}) : super(key: key);

  final String userName;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _messages = <Message>[
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
          bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 60.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    tooltip: 'Home',
                    onPressed: _goHome,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: _goSearch,
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    tooltip: 'Settings',
                    onPressed: _goSettings,
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    tooltip: 'Profile',
                    onPressed: _goProfile,
                  ),
                ],
              ),
            ),
          )),
    );
  }

/*
* **** ROUTES NAVIGATOR ****
*/
  void _goHome() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
      log("changed route to Home");
      return Home(userName: widget.userName);
    }));
  }

  void _goSearch() {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      return Login();
    })));
  }

  void _goSettings() {}
  void _goProfile() {}

  void _pushMessages() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _messages.map((message) {
            return ListTile(
                isThreeLine: false,
                title: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute<void>(builder: ((context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(message.username),
                          centerTitle: true,
                        ),
                      );
                    })));
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
