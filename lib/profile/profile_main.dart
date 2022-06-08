import 'package:dreamsanctuary/allWidgets/bottom_bar.dart';
import 'package:dreamsanctuary/models/dsuser.dart';
import 'package:flutter/material.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key, required this.user, required this.context}) : super(key: key);
  final DSUser user;
  final BuildContext context;
  @override
  State<StatefulWidget> createState() => ProfileMainState();
}

class ProfileMainState extends State<ProfileMain> {
  final GlobalKey<ScaffoldState> _mainScaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mainScaffoldKey,
      appBar: AppBar(
        title: const Text('Dream Sanctuary'),
      ),
      bottomNavigationBar:
          DreamSanctuaryBottomBar(context, widget.user, _mainScaffoldKey).createDreamSanctuaryBottomBar(),
    );
  }
}
