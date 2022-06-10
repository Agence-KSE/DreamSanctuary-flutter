import 'dart:js';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsanctuary/allConstants/all_constants.dart';
import 'package:dreamsanctuary/models/dsuser.dart';
import 'package:dreamsanctuary/screens/creator_profile.dart';
import 'package:dreamsanctuary/screens/profile_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Content extends Equatable {
  late final String id;
  late final String contentType;
  late final String uploadTimestamp;
  late final String url;
  late final String userid;
  late final List<dynamic> users;

  Content(
      {required String id,
      required String contentType,
      required String uploadTimestamp,
      required String url,
      required String userid,
      required List<dynamic> users}) {
    this.id = id;
    this.contentType = contentType;
    this.uploadTimestamp = uploadTimestamp;
    this.url = url;
    this.userid = userid;
    this.users = users;
  }

  void _gotoProfilePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return const ProfilePage();
    })));
  }

  void _goToCreatorProfile(BuildContext context, Content content) async {
    // get creator from content
    DSUser creator = await DSUser.getFromUserReference(content.userid);
    print("creator : " + creator.username);

    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return CreatorProfile().buildCreatorProfile(context, creator);
    })));
  }

  Future<Widget> buildContent(BuildContext context, bool blur) async {
    DSUser author = await DSUser.getFromUserReference(this.userid);
    // TODO solution ici ? https://stackoverflow.com/questions/28238161/how-to-make-an-asynchronous-dart-call-synchronous
    // AVATAR - NAME
    // IMAGE
    // LIKE - FAV
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            onTap: () => _goToCreatorProfile(context, this),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(this.url), fit: BoxFit.cover),
                    ),
                    child: blur
                        ? ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                          )
                        : Container(),
                  ),

                  /*ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      this.url,
                      fit: BoxFit.contain,
                      width: 300,

                      //height: 500,
                    ),
                  ),*/
                  ListTile(
                    textColor: Colors.pink,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(author.username),
                        //Text(this.user.split('/')[1]),
                        Text(this.uploadTimestamp),
                      ],
                    ),
                    subtitle: Text(this.contentType),
                  ),
                ]),
          )),
    );
  }

  static Future<DSUser> getUser(String userPath) async {
    return await DSUser.getFromUserReference(userPath);
  }

  factory Content.fromDocument(DocumentSnapshot snapshot) {
    String contentType = "";
    String uploadTimestamp = "";
    String url = "";
    String userid = "";
    List<dynamic> users = [];

    try {
      contentType = snapshot.get(FirestoreConstants.contentType);
      uploadTimestamp = snapshot.get(FirestoreConstants.uploadTimestamp);
      url = snapshot.get(FirestoreConstants.url);
      userid = snapshot.get(FirestoreConstants.userid);
      users = snapshot.get(FirestoreConstants.users);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Content(
        id: snapshot.id,
        contentType: contentType,
        userid: userid,
        uploadTimestamp: uploadTimestamp,
        url: url,
        users: users);
  }

  Content copyWith({
    String? id,
    String? contentType,
    String? userid,
    String? uploadTimestamp,
  }) =>
      Content(
          id: id ?? this.id,
          contentType: contentType ?? this.contentType,
          userid: userid ?? this.userid,
          uploadTimestamp: uploadTimestamp ?? this.uploadTimestamp,
          url: url,
          users: users);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.contentType: contentType,
        FirestoreConstants.userid: userid,
        FirestoreConstants.uploadTimestamp: uploadTimestamp
      };

  @override
  List<Object?> get props => [id, contentType, userid, uploadTimestamp, url, users];

  @override
  String toString() {
    return "id : " + this.id + " contentType : " + this.contentType + " uploadTimestamp : " + this.uploadTimestamp;
  }
}
