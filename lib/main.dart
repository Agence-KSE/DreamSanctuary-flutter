import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsanctuary/firebase_options.dart';
import 'package:dreamsanctuary/providers/chat_page_provider.dart';
import 'package:dreamsanctuary/providers/chat_provider.dart';
import 'package:dreamsanctuary/providers/home_page_provider.dart';
import 'package:dreamsanctuary/providers/profile_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dreamsanctuary/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Platform  Firebase App Id
web       1:795065301225:web:87462cf240952b1949d878
android   1:795065301225:android:6e78004b06a7c3bf49d878
ios       1:795065301225:ios:2b6caf0cdcaedca349d878
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.prefs}) : super(key: key);
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ProfileProvider>(
              create: (_) => ProfileProvider(
                  prefs: prefs,
                  firebaseFirestore: firebaseFirestore,
                  firebaseStorage: firebaseStorage)),
          Provider<ChatPageProvider>(
              create: (_) => ChatPageProvider(
                  /*prefs: prefs,
                  firebaseStorage: firebaseStorage,*/
                  firebaseFirestore: firebaseFirestore)),
          Provider<ChatProvider>(
            create: (_) => ChatProvider(
                prefs: prefs,
                firebaseStorage: firebaseStorage,
                firebaseFirestore: firebaseFirestore),
          ),
          Provider<HomePageProvider>(
              create: (_) => HomePageProvider(
                  /*prefs: prefs,
                  firebaseStorage: firebaseStorage,*/
                  firebaseFirestore: firebaseFirestore))
        ],
        child: MaterialApp(
          title: 'Dream Sanctuary',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 54, 79, 107),
              foregroundColor: Color.fromARGB(255, 228, 249, 245),
            ),
          ),
          //home: const DefaultList(),
          home: Login(),
        ));
  }
}
