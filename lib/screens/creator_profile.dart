import 'package:dreamsanctuary/models/dsuser.dart';
import 'package:flutter/cupertino.dart';

class CreatorProfile extends StatelessWidget {
  late DSUser creator;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(creator.username),
          Image.network(creator.photoUrl),
        ],
      ),
    );
  }

  Widget buildCreatorProfile(BuildContext context, DSUser creator) {
    this.creator = creator;
    return build(context);
  }
}
