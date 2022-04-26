import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWord extends StatefulWidget{
  @override
  RandomWordState createState() => RandomWordState();
}

class RandomWordState extends State<RandomWord>{
  final _randomWordPairs=<WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildlist(){
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context,item){
        if(item.isOdd) return Divider();

        final index = item ~/2;

        if(index >= _randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));

        }

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(title: Text(pair.asPascalCase,
        style: TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite: Icons.favorite_border,
        color: alreadySaved ? Colors.red : null),
        onTap: (){
          setState(() {
            if(alreadySaved){
              _savedWordPairs.remove(pair);
            } else{
              _savedWordPairs.add(pair);
            }
          });
        },
    );

  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context){
            final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
              return ListTile(
                title: Text(pair.asPascalCase,
                  style: TextStyle(fontSize: 16.0),),
              );
            });
      final List<Widget> divied = ListTile.divideTiles(
          context: context,
          tiles: tiles
      ).toList();


      return Scaffold(
        appBar: AppBar(
          title: Text('Saved pairs'),
        ),
        body: ListView(children: divied)  );
      }
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('WordPair by SINA'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.list),
                onPressed: _pushSaved,
              )
            ],    
        ),
        body: _buildlist());
  }
}