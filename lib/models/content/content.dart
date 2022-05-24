import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/annotation.dart';
import 'package:dreamsanctuary/allConstants/all_constants.dart';
import 'package:dreamsanctuary/models/chat_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Content extends Equatable {
  late final String id;
  late final String contentType;
  late final String uploadTimestamp;
  late final String url;
  late final String user;

  Content(
      {required String id,
      required String contentType,
      required String user,
      required String uploadTimestamp,
      required String url}) {
    this.id = id;
    this.contentType = contentType;
    this.uploadTimestamp = uploadTimestamp;
    this.url = url;
    this.user = user;
  }

  Widget buildContent() {
    // AVATAR - NAME
    // IMAGE
    // LIKE - FAV
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            onTap: () => print("bye bye!"),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      // "https://firebasestorage.googleapis.com/v0/b/dream-sanctuary-42daf.appspot.com/o/content%2Fwallhaven-eyxpvw.jpg?alt=media&token=ee01e73d-3111-45d8-92b8-3818c0e268ae",
                      this.url,
                      fit: BoxFit.contain,
                      width: 300,
                      //height: 500,
                    ),
                  ),
                  ListTile(
                    textColor: Colors.pink,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          this.user.split('/')[1],
                        ),
                        Text(this.uploadTimestamp),
                      ],
                    ),
                    subtitle: Text(this.contentType),
                  ),
                ]),
          )

          // Row(
          //   children: [
          //     Image.network(
          //       "https://firebasestorage.googleapis.com/v0/b/dream-sanctuary-42daf.appspot.com/o/content%2Fwallhaven-eyxpvw.jpg?alt=media&token=ee01e73d-3111-45d8-92b8-3818c0e268ae",
          //       fit: BoxFit.contain,
          //       width: 300,
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     const Icon(Icons.favorite_border_rounded),
          //     const Icon(Icons.save_alt_rounded)
          //   ],
          // ),
          ),
    );
  }

  static Future<ChatUser> getUser(String userPath) async {
    return await ChatUser.getFromId(userPath);
  }

  factory Content.fromDocument(DocumentSnapshot snapshot) {
    String contentType = "";
    String user = "";
    String uploadTimestamp = "";
    String url = "";

    ChatUser usr;

    try {
      contentType = snapshot.get(FirestoreConstants.contentType);
      uploadTimestamp = snapshot.get(FirestoreConstants.uploadTimestamp);
      url = snapshot.get(FirestoreConstants.url);
      user = snapshot.get(FirestoreConstants.user).path;
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
        url: url);
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
          url: url);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.contentType: contentType,
        FirestoreConstants.user: user,
        FirestoreConstants.uploadTimestamp: uploadTimestamp
      };

  @override
  List<Object?> get props => [id, contentType, user, uploadTimestamp];

  @override
  String toString() {
    return "id : " +
        this.id +
        " contentType : " +
        this.contentType +
        " uploadTimestamp : " +
        this.uploadTimestamp;
  }
}
