import 'package:flutter/material.dart';
import 'package:not_hesaplamaa/constants/app_constants.dart';
import 'package:not_hesaplamaa/widgets/ortalama_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ortalama Hesapla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Sabitler.anaRenk,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const OrtalamaHesapla(),
    );
  }
}
