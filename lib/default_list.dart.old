import 'package:flutter/material.dart';

class DefaultList extends StatefulWidget {
  const DefaultList({Key? key}) : super(key: key);

  @override
  DefaultListState createState() => DefaultListState();
}

class DefaultListState extends State<DefaultList> {
  // final _suggestions = <WordPair>[];
  final _saved = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  var listNames = <String>["Belle Delphine", "Amouranth", "test", "test"];

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved creators'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Sanctuary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: listNames.length,
        itemBuilder: (context, i) {
          final alreadySaved = _saved.contains(listNames[i]);
          return ListTile(
              title: Text(
                listNames[i],
                style: _biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved
                    ? const Color.fromARGB(255, 204, 0, 255)
                    : null,
                semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(listNames[i]);
                  } else {
                    _saved.add(listNames[i]);
                  }
                });
              });
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
