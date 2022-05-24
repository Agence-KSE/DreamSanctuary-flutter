import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:dreamsanctuary/allConstants/all_constants.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

@JsonSerializable(explicitToJson: true)
class ChatUser extends Equatable {
  final String id;
  final String photoUrl;
  final String username;
  final String phoneNumber;
  final String aboutMe;

  String toString() {
    return this.id +
        " - " +
        this.photoUrl +
        " - " +
        this.username +
        " - " +
        this.phoneNumber +
        " - " +
        this.aboutMe;
  }

  const ChatUser(
      {required this.id,
      required this.photoUrl,
      required this.username,
      required this.phoneNumber,
      required this.aboutMe});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? email,
  }) =>
      ChatUser(
          id: id ?? this.id,
          photoUrl: photoUrl ?? this.photoUrl,
          username: nickname ?? username,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          aboutMe: email ?? aboutMe);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.username: username,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.phoneNumber: phoneNumber,
        FirestoreConstants.aboutMe: aboutMe,
      };
  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String aboutMe = "";

    try {
      photoUrl = snapshot.get(FirestoreConstants.photoUrl);
      nickname = snapshot.get(FirestoreConstants.username);
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      aboutMe = snapshot.get(FirestoreConstants.aboutMe);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
        id: snapshot.id,
        photoUrl: photoUrl,
        username: nickname,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe);
  }
  @override
  List<Object?> get props => [id, photoUrl, username, phoneNumber, aboutMe];

  static ChatUser getFromId(String id) {
    ChatUser loading = ChatUser(
        id: '',
        photoUrl: '',
        username: 'loading',
        phoneNumber: '',
        aboutMe: '');

    FirebaseFirestore.instance
        .collection('users')
        // get only username, not collection name (ex : users/admin)
        .doc(id.split('/')[1])
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        return ChatUser.fromDocument(documentSnapshot);
      } else {
        print('Document does not exist on the database');
        return loading;
      }
    });
    return loading;
  }
}
