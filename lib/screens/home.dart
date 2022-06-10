import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsanctuary/models/content/content.dart';
import 'package:dreamsanctuary/models/dsuser.dart';
import 'package:dreamsanctuary/profile/profile_drawer.dart';
import 'package:dreamsanctuary/providers/home_page_provider.dart';
import 'package:dreamsanctuary/screens/chat_page_home.dart';
import 'package:dreamsanctuary/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:dreamsanctuary/allConstants/all_constants.dart';
import 'package:dreamsanctuary/allWidgets/loading_view.dart';
//import 'package:smart_talk/providers/auth_provider.dart';
//import 'package:smart_talk/screens/login_page.dart';
import 'package:dreamsanctuary/utilities/debouncer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final DSUser currentUser;
  const Home({Key? key, required DSUser user})
      : this.currentUser = user,
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isInitialized = false;

  // content documentReference firestore
  DocumentReference contentRef = FirebaseFirestore.instance.collection("content").doc();

  int _limit = 20;
  final int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late HomePageProvider homePageProvider;
  late ProfileDrawer pfd;

  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> buttonClearController = StreamController<bool>();
  TextEditingController searchTextEditingController = TextEditingController();

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    buttonClearController.close();
  }

  @override
  void initState() {
    super.initState();
    // authProvider = context.read<AuthProvider>();
    homePageProvider = context.read<HomePageProvider>();

    // profile drawer
    pfd = new ProfileDrawer(widget.currentUser, context);
    // if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
    //   currentUserId = authProvider.getFirebaseUserId()!;
    // } else {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => const LoginPage()),
    //       (Route<dynamic> route) => false);
    // }

    scrollController.addListener(scrollListener);
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Dream Sanctuary'),
      centerTitle: false,
      leading: GestureDetector(
        onTap: () => _signOut(),
        child: const Icon(Icons.login_outlined),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.message_sharp),
          tooltip: 'Messages',
          onPressed: () => _pushMessages(this.context),
        ),
        IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      print("login");
      Fluttertoast.showToast(msg: 'Welcome back!', backgroundColor: Colors.pink, timeInSecForIosWeb: 3);
      isInitialized = true;
    }

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: pfd.createProfileDrawer(),
        ),
        appBar: buildAppBar(),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(
            children: [
              Column(
                children: [
                  // buildSearchBar(),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: homePageProvider.getFirestoreData(
                          FirestoreConstants.pathContentCollection, _limit, _textSearch),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.length > 0) {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => buildItem(context, snapshot.data?.docs[index]),
                              controller: scrollController,
                              separatorBuilder: (BuildContext context, int index) => const Divider(),
                            );
                          } else {
                            return const Center(
                              child: Text('No user found...'),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                child: isLoading ? const LoadingView() : const SizedBox.shrink(),
              ),
            ],
          ),
        ));
  }

  void _pushMessages(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return const ChatPageHome();
    })));
  }

  Future<bool> onBackPress() {
    // openDialog();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => Home(
                  user: new DSUser.FromDSUser(widget.currentUser),
                )),
        (Route<dynamic> route) => false);
    return Future.value(false);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
              return Login();
            })));
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(Sizes.dimen_10),
      height: Sizes.dimen_50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: Sizes.dimen_10,
          ),
          const Icon(
            Icons.person_search,
            color: AppColors.white,
            size: Sizes.dimen_24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchTextEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  buttonClearController.add(true);
                  setState(() {
                    _textSearch = value;
                  });
                } else {
                  buttonClearController.add(false);
                  setState(() {
                    _textSearch = "";
                  });
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: AppColors.white),
              ),
            ),
          ),
          StreamBuilder(
              stream: buttonClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                        onTap: () {
                          searchTextEditingController.clear();
                          buttonClearController.add(false);
                          setState(() {
                            _textSearch = '';
                          });
                        },
                        child: const Icon(
                          Icons.clear_rounded,
                          color: AppColors.greyColor,
                          size: 20,
                        ),
                      )
                    : const SizedBox.shrink();
              })
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_30),
        color: AppColors.spaceLight,
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      print(" ---------- BUILDING CONTENT... ----------");
      Content content = Content.fromDocument(documentSnapshot);
      print("users 0 : " + content.users[0]);
      print("current user : " + widget.currentUser.username);

      // if user not found in authorized users, let's blur that shit
      return content.buildContent(this.context, widget.currentUser, !content.users.contains(widget.currentUser.id));
    } else {
      return const SizedBox.shrink();
    }
  }
}
