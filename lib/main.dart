import 'package:flutter/material.dart';
import 'package:ppb_ets_2024/pages/film_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Film Catalog',
      home: Scaffold(
        body: Center(
          child: FilmListPage(),
        ),
      ),
    );
  }
}
