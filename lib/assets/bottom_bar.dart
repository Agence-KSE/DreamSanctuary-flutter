import 'dart:developer';

import 'package:dream_sanctuary/home.dart';
import 'package:dream_sanctuary/login.dart';
import 'package:dream_sanctuary/profile/profile_main.dart';
import 'package:flutter/material.dart';

class DreamSanctuaryBottomBar extends BottomAppBar {
  final BuildContext context;
  final String username;

  DreamSanctuaryBottomBar(this.context, this.username);

  BottomAppBar createDreamSanctuaryBottomBar() {
    return BottomAppBar(
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
    );
  }

/*
* **** ROUTES NAVIGATOR ****
*/
  void _goHome() {
    Navigator.of(this.context).pushReplacement(PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
      log("changed route to Home");
      return Home(username: this.username);
    }));
  }

  void _goSearch() {
    Navigator.of(this.context).push(MaterialPageRoute(builder: ((context) {
      return Login();
    })));
  }

  void _goSettings() {}
  void _goProfile() {
    Navigator.of(this.context).push(MaterialPageRoute(builder: (context) {
      return ProfileMain(
        username: username,
        context: context,
      );
    }));
  }
}
