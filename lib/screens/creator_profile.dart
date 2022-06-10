import 'package:dreamsanctuary/models/dsuser.dart';
import 'package:flutter/cupertino.dart';

class CreatorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Creator's name"),
          Image.network(
              "https://firebasestorage.googleapis.com/v0/b/dream-sanctuary-42daf.appspot.com/o/content%2Fa9447994318e7771c1e8d00deb8d551a%20-%20Copie.jpg?alt=media&token=94d27158-e191-4ecf-9d46-b6fa06e8e49c")
        ],
      ),
    );
  }

  Widget buildCreatorProfile(BuildContext context, DSUser creator) {
    print(creator.toString());
    return Container(
      child: Column(
        children: [
          Text(creator.username),
          Image.network(
              "https://firebasestorage.googleapis.com/v0/b/dream-sanctuary-42daf.appspot.com/o/content%2Fa9447994318e7771c1e8d00deb8d551a%20-%20Copie.jpg?alt=media&token=94d27158-e191-4ecf-9d46-b6fa06e8e49c")
        ],
      ),
    );
  }
}
