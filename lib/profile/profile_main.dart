import 'package:dream_sanctuary/assets/bottom_bar.dart';
import 'package:flutter/material.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key, required this.username, required this.context})
      : super(key: key);
  final String username;
  final BuildContext context;
  @override
  State<StatefulWidget> createState() => ProfileMainState();
}

class ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Sanctuary'),
      ),
      bottomNavigationBar: DreamSanctuaryBottomBar(context, widget.username)
          .createDreamSanctuaryBottomBar(),
    );
  }
}
