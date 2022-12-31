import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final suggestions = <WordPair>[];
  final saved = <WordPair>{};
  void showSaved() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Page2(saved: saved),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Random Names'),
          actions: [
            IconButton(
              onPressed: showSaved,
              icon: Icon(Icons.menu),
              tooltip: 'Show saved',
            )
          ],
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(16),
            itemBuilder: (context, i) {
              if (i.isOdd) return Divider();
              final index = i ~/ 2;
              if (index >= suggestions.length) {
                suggestions.addAll(generateWordPairs().take(10));
              }
              final alreadySaved = saved.contains(suggestions[index]);
              return ListTile(

                title: Text(
                  suggestions[index].asPascalCase,
                  style: TextStyle(fontSize: 20,),
                ),
                trailing: Icon(
                  alreadySaved
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                ),
                onTap: () {
                  setState(() {
                    print(suggestions[index].asCamelCase);
                    if (alreadySaved) {
                      saved.remove(suggestions[index]);
                    } else {
                      saved.add(suggestions[index]);
                    }
                  });
                },
              );
            }));
  }
}

class Page2 extends StatelessWidget {
  var saved = <WordPair>{};
  Page2({super.key, required this.saved});

  @override
  Widget build(BuildContext context) {
    final tiles = saved.map((pair) {//using .map, we iterate the set saved and read each value which is named pair and do operations on the value pair
      return ListTile(
        title: Text(pair.asCamelCase),
      );
    });
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
        : <Widget>[];
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved names'),
        ),
        body: ListView(children: divided));
  }
}
