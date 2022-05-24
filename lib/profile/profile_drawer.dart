import 'package:dreamsanctuary/screens/login.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends Drawer {
  final _biggerFont =
      const TextStyle(fontSize: 18, height: 3, fontWeight: FontWeight.bold);
  final String username;
  final BuildContext context;
  ProfileDrawer(this.username, this.context);

  Drawer createProfileDrawer() {
    return Drawer(
        child: Column(
      children: [
        Text(
          username,
          style: _biggerFont,
        ),
        Container(
          width: 150,
          height: 150,
          margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background_login.jpg"),
                  fit: BoxFit.cover),
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
        // row chiffres
        IntrinsicHeight(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  const Icon(Icons.event_note_rounded),
                  const Text("14.7 K posts")
                ]),
                const VerticalDivider(
                  width: 5,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Column(children: [
                  const Icon(Icons.people_alt_outlined),
                  const Text("32.8 K dreamers")
                ]),
                const VerticalDivider(
                  width: 5,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Column(children: [
                  const Icon(Icons.attach_money),
                  const Text("\$ 492 K/month")
                ]),
              ]),
        ),
        // buttons
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () {
                    debugPrint('Received click');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home_rounded),
                        const Text(" My Sanctuary")
                      ]),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2.0),
              child: SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () {
                    debugPrint('Received click');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_alt_outlined),
                        const Text(" My Dreamers")
                      ]),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2.0),
              child: SizedBox(
                width: 300,
                child: OutlinedButton(
                  onPressed: () {
                    debugPrint('Received click');
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.settings),
                        const Text(" Settings")
                      ]),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0, top: 2.0),
              child: SizedBox(
                width: 300,
                child: OutlinedButton(
                    onPressed: () {
                      debugPrint('Received click');
                      Navigator.of(this.context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return Login();
                      })));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout),
                          const Text(" Log out")
                        ])),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
