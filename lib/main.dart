import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final wordPair = WordPair.random();
    return MaterialApp(
      theme: ThemeData.light().copyWith(
       appBarTheme: AppBarTheme(color: Colors.deepPurple)
      ),
      home: RandomWord()
    );
  }

}