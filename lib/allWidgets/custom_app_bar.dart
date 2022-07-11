import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/dsuser.dart';
import '../screens/chat_page_home.dart';

class CustomAppBar extends AppBar {
  late final DSUser currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PreferredSizeWidget build(DSUser currentUser, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Welcome to Dream Sanctuary, ' + currentUser.username + "!"),
      centerTitle: false,
      /* left icon 
      leading: GestureDetector(
        onTap: () => _signOut(),
        child: const Icon(Icons.login_outlined),
      ),*/
      actions: [
        IconButton(
          icon: const Icon(Icons.message_sharp),
          tooltip: 'Messages',
          onPressed: () => _pushMessages(context),
        ),
        IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer())
      ],
    );
  }

  void _pushMessages(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return const ChatPageHome();
    })));
  }
}
