import 'package:dreamsanctuary/allWidgets/custom_app_bar.dart';
import 'package:dreamsanctuary/models/dsuser.dart';
import 'package:flutter/material.dart';

import '../profile/profile_drawer.dart';
//import 'package:smart_talk/providers/auth_provider.dart';
//import 'package:smart_talk/screens/login_page.dart';

class CreatorProfile extends StatefulWidget {
  final DSUser creator;
  final DSUser currentUser;
  const CreatorProfile({Key? key, required DSUser creator, required DSUser currentUser})
      : this.creator = creator,
        this.currentUser = currentUser,
        super(key: key);
  @override
  State<CreatorProfile> createState() => _CreatorProfileState();
}

class _CreatorProfileState extends State<CreatorProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late ProfileDrawer pfd;

  @override
  void initState() {
    super.initState();
    // profile drawer
    pfd = new ProfileDrawer(widget.currentUser, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar().build(widget.currentUser, context),
      endDrawer: Drawer(
        child: pfd.createProfileDrawer(),
      ),
      body: Scaffold(
          body: GridView.count(
        crossAxisCount: 3,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(3, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }),
      )),
    );
  }
}

            /*Column(
        children: [
          Text(widget.creator.username),
          Image.network(widget.creator.photoUrl),
          GridView.count(
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(3, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            }),
          ),
        ],
      ),*/