import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppb_ets_2024/model/film.dart';

class FilmDetailWidget extends StatelessWidget {
  final Film film;
  const FilmDetailWidget({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(film.createdTime);
    return Card(
      child: Column(
        children: [
          Image.network(film.imageUrl),
          Text(time),
          Text(film.description)
        ],
      ),
    );
  }
}
