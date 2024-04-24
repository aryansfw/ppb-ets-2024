import 'package:flutter/material.dart';
import 'package:ppb_ets_2024/model/film.dart';

class FilmCardWidget extends StatelessWidget {
  final Film film;

  const FilmCardWidget({super.key, required this.film});

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [Text(film.title), Text(film.description)],
        ),
      );
}
