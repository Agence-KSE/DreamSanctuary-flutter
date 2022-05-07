import 'package:uuid/uuid.dart';

class User {
  static var uuid = Uuid();
  String id = "";
  final String username;
  final String email;

  User(this.username, this.email) {
    this.id = uuid.v1();
  }
}
