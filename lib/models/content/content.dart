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
  late final String user;
  late final List<dynamic> users;

  Content(
      {required String id,
      required String contentType,
      required String uploadTimestamp,
      required String url,
      required String user,
      required List<dynamic> users}) {
    this.id = id;
    this.contentType = contentType;
    this.uploadTimestamp = uploadTimestamp;
    this.url = url;
    this.user = user;
    this.users = users;
  }

  void _gotoProfilePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return const ProfilePage();
    })));
  }

  void _goToCreatorProfile(BuildContext context, Content content) async {
    // get creator from content
    print("get from : " + content.user);
    DSUser creator = await DSUser.getFromUserReference(content.user);
    print("creator : " + creator.username);

    Navigator.of(context).push(MaterialPageRoute<void>(builder: ((context) {
      return CreatorProfile().buildCreatorProfile(context, creator);
    })));
  }

  Widget buildContent(BuildContext context, DSUser currentUser, bool blur) {
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
                        Text(this.user.split('/')[1]),
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
    String user = "";
    String uploadTimestamp = "";
    String url = "";
    List<dynamic> users = [];

    try {
      contentType = snapshot.get(FirestoreConstants.contentType);
      uploadTimestamp = snapshot.get(FirestoreConstants.uploadTimestamp);
      url = snapshot.get(FirestoreConstants.url);
      user = snapshot.get(FirestoreConstants.user).path;
      users = snapshot.get(FirestoreConstants.users);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Content(
        id: snapshot.id,
        contentType: contentType,
        user: user,
        uploadTimestamp: uploadTimestamp,
        url: url,
        users: users);
  }

  Content copyWith({
    String? id,
    String? contentType,
    String? user,
    String? uploadTimestamp,
  }) =>
      Content(
          id: id ?? this.id,
          contentType: contentType ?? this.contentType,
          user: user ?? this.user,
          uploadTimestamp: uploadTimestamp ?? this.uploadTimestamp,
          url: url,
          users: users);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.contentType: contentType,
        FirestoreConstants.user: user,
        FirestoreConstants.uploadTimestamp: uploadTimestamp
      };

  @override
  List<Object?> get props => [id, contentType, user, uploadTimestamp, url, users];

  @override
  String toString() {
    return "id : " + this.id + " contentType : " + this.contentType + " uploadTimestamp : " + this.uploadTimestamp;
  }
}
