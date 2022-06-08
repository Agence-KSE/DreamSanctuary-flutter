import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:dreamsanctuary/allConstants/all_constants.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class DSUser extends Equatable {
  late String id;
  late String email;
  late String username;
  late String aboutMe;
  late String photoUrl;
  late String phoneNumber;

  String toString() {
    return this.id + " - " + this.photoUrl + " - " + this.username + " - " + this.phoneNumber + " - " + this.aboutMe;
  }

  // default constructor
  DSUser({required this.id});

  // complete constructor
  DSUser.DSUserComplete(
      {required this.id,
      required this.email,
      required this.username,
      required this.photoUrl,
      required this.phoneNumber,
      required this.aboutMe});

  // constructor from an already existing DSUser
  DSUser.FromDSUser(DSUser user) {
    this.id = user.id;
    this.email = user.email;
    this.username = user.username;
    this.photoUrl = user.photoUrl;
    this.phoneNumber = user.phoneNumber;
    this.aboutMe = user.aboutMe;
  }

  DSUser.FromUser(User user) {
    this.id = user.uid;
    this.email = '';
    this.username = '';
    this.photoUrl = '';
    this.phoneNumber = '';
    this.aboutMe = '';
  }

  DSUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? email,
  }) =>
      DSUser.DSUserComplete(
          id: id ?? this.id,
          photoUrl: photoUrl ?? this.photoUrl,
          username: nickname ?? username,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          aboutMe: email ?? aboutMe,
          email: email ?? this.email);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.username: username,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.phoneNumber: phoneNumber,
        FirestoreConstants.aboutMe: aboutMe,
      };
  factory DSUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String aboutMe = "";
    String email = "";

    try {
      photoUrl = snapshot.get(FirestoreConstants.photoUrl);
      nickname = snapshot.get(FirestoreConstants.username);
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      aboutMe = snapshot.get(FirestoreConstants.aboutMe);
      email = snapshot.get(FirestoreConstants.email);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return DSUser.DSUserComplete(
        id: snapshot.id,
        photoUrl: photoUrl,
        username: nickname,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe,
        email: email);
  }
  @override
  List<Object?> get props => [id, photoUrl, username, phoneNumber, aboutMe];

  static DSUser getFromId(String id) {
    DSUser loading =
        DSUser.DSUserComplete(id: '', photoUrl: '', username: 'loading', phoneNumber: '', aboutMe: '', email: '');

    FirebaseFirestore.instance
        .collection('DSUsers')
        // get only username, not collection name (ex : DSUsers/admin)
        .doc(id.split('/')[1])
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        return DSUser.fromDocument(documentSnapshot);
      } else {
        print('Document does not exist on the database');
        return loading;
      }
    });
    return loading;
  }
}
