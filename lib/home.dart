import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsanctuary/assets/bottom_bar.dart';
import 'package:dreamsanctuary/profile/profile_drawer.dart';
import 'package:dreamsanctuary/providers/chat_page_provider.dart';
import 'package:dreamsanctuary/screens/chat_page_home.dart';
import 'package:flutter/material.dart';
import 'package:dreamsanctuary/data/Message.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // key to open drawer from bottom_bar
  final GlobalKey<ScaffoldState> _homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late ChatPageProvider homeProvider = context.read<ChatPageProvider>();

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
          key: _homeScaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'New post...',
            child: const Icon(Icons.add),
            elevation: 2.0,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          bottomNavigationBar: new DreamSanctuaryBottomBar(
                  context, widget.username, _homeScaffoldKey)
              .createDreamSanctuaryBottomBar(),
          endDrawer: ProfileDrawer(widget.username, this.context)
              .createProfileDrawer(),
        ));
  }

  void _pushMessages() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return const ChatPageHome();
    })));
  }
}
