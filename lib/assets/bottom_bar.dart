import 'dart:developer';

import 'package:dreamsanctuary/home.dart';
import 'package:dreamsanctuary/login.dart';
import 'package:dreamsanctuary/profile/profile_drawer.dart';
import 'package:flutter/material.dart';

class DreamSanctuaryBottomBar extends BottomAppBar {
  final BuildContext context;
  final String username;
  final GlobalKey<ScaffoldState> _homeScaffoldKey;

  DreamSanctuaryBottomBar(this.context, this.username, this._homeScaffoldKey);

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
              onPressed: () => _homeScaffoldKey.currentState!.openEndDrawer(),
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
    log("Open profile drawer");
    ProfileDrawer(username, this.context).createProfileDrawer();
  }
}
