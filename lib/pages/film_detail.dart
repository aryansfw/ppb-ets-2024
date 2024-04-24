import 'package:flutter/material.dart';
import 'package:ppb_ets_2024/db/film_database.dart';
import 'package:ppb_ets_2024/model/film.dart';
import 'package:ppb_ets_2024/pages/add_film.dart';
import 'package:ppb_ets_2024/widget/film_detail_widget.dart';

class FilmDetailPage extends StatefulWidget {
  final int filmId;

  const FilmDetailPage({
    super.key,
    required this.filmId,
  });

  @override
  State<FilmDetailPage> createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  late Film film;
  bool isLoading = false;

  @override
  initState() {
    super.initState();

    refreshFilms();
  }

  Future refreshFilms() async {
    setState(() => isLoading = true);

    film = await FilmDatabase.instance.readFilm(widget.filmId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(isLoading ? '' : film.title),
      ),
      body: isLoading ? const Text('Loading...') : FilmDetailWidget(film: film),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddFilmPage(
                        film: film,
                      )),
            );
          }));
}
