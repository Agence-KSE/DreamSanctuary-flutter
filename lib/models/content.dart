import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dreamsanctuary/models/chat_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../allConstants/all_constants.dart';

class Content extends Equatable {
  final String id;
  final String contentType;
  final ChatUser user;
  final String uploadTimestamp;

  const Content(
      {required this.id,
      required this.contentType,
      required this.user,
      required this.uploadTimestamp});

  factory Content.fromDocument(DocumentSnapshot snapshot) {
    String contentType = "";
    ChatUser user = new ChatUser(
        id: "", photoUrl: "", username: "", phoneNumber: "", aboutMe: "");
    String uploadTimestamp = "";

    try {
      contentType = snapshot.get(FirestoreConstants.contentType);
      user = snapshot.get(FirestoreConstants.user);
      uploadTimestamp = snapshot.get(FirestoreConstants.uploadTimestamp);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Content(
        id: snapshot.id,
        contentType: contentType,
        user: user,
        uploadTimestamp: uploadTimestamp);
  }

  @override
  List<Object?> get props => [id, contentType, user, uploadTimestamp];
}
