// @dart=2.9
import 'package:flutter/material.dart';
import 'package:sqlliteapp/screens/NotAyrintilari.dart';
import 'screens/notListesiKayitEkle.dart';
import 'screens/NotListesi.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Not Ekleme Denemesi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotListesi(),
    );
  }
}