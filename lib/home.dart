import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.userName}) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dream Sanctuary'),
      ),
      body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
            elevation: 2.0,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 45.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
