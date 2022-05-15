import 'dart:core';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsanctuary/allConstants/all_constants.dart';
import 'package:dreamsanctuary/assets/bottom_bar.dart';
import 'package:dreamsanctuary/models/content.dart';
import 'package:dreamsanctuary/profile/profile_drawer.dart';
import 'package:dreamsanctuary/providers/chat_page_provider.dart';
import 'package:dreamsanctuary/providers/home_page_provider.dart';
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
  int _limit = 20;
  String _textSearch = "";

  // key to open drawer from bottom_bar
  final GlobalKey<ScaffoldState> _homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late HomePageProvider homePageProvider;

  @override
  void initState() {
    super.initState();
    homePageProvider = context.read<HomePageProvider>();
  }

  Future<bool> onBackPress() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Home(username: widget.username)),
        (Route<dynamic> route) => false);
    return Future.value(false);
  }

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
              onPressed: () => _pushMessages(this.context),
            )
          ],
        ),
        body: Builder(
          builder: (BuildContext newContext) {
            return Scaffold(
              body: WillPopScope(
                  onWillPop: onBackPress,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: homePageProvider.getFirestoreData(
                                  FirestoreConstants.pathContentCollection,
                                  _limit,
                                  _textSearch),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  if ((snapshot.data?.docs.length ?? 0) > 0) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) =>
                                          buildItem(context,
                                              snapshot.data?.docs[index]),
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                    );
                                  } else {
                                    return const Center(
                                        child: Text('No content found'));
                                  }
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
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
            );
          },
        ));
    /*Scaffold(
          body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: homePageProvider.getFirestoreData(
                        FirestoreConstants.pathContentCollection,
                        _limit,
                        _textSearch),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if ((snapshot.data?.docs.length ?? 0) > 0) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) =>
                                buildItem(context, snapshot.data?.docs[index]),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          );
                        }
                      }
                      // else not found
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New post...',
        child: const Icon(Icons.add),
        elevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: new DreamSanctuaryBottomBar(
              context, widget.username, _homeScaffoldKey)
          .createDreamSanctuaryBottomBar(),
      endDrawer:
          ProfileDrawer(widget.username, this.context).createProfileDrawer(),
    );*/
  }
}

void _pushMessages(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
    return const ChatPageHome();
  })));
}

Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
  if (documentSnapshot != null) {
    Content content = Content.fromDocument(documentSnapshot);
    if (content.id != "") {
      return Text("Found : " + content.uploadTimestamp);
    }
  }
  return const SizedBox.shrink();
}
