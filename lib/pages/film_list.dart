import 'package:flutter/material.dart';
import 'package:ppb_ets_2024/db/film_database.dart';
import 'package:ppb_ets_2024/model/film.dart';
import 'package:ppb_ets_2024/pages/add_film.dart';
import 'package:ppb_ets_2024/pages/film_detail.dart';
import 'package:ppb_ets_2024/widget/film_card_widget.dart';

class FilmListPage extends StatefulWidget {
  const FilmListPage({super.key});

  @override
  State<FilmListPage> createState() => _FilmListPageState();
}

class _FilmListPageState extends State<FilmListPage> {
  late List<Film> films;
  bool isLoading = false;

  @override
  initState() {
    super.initState();

    refreshFilms();
  }

  @override
  void dispose() {
    FilmDatabase.instance.close();

    super.dispose();
  }

  Future refreshFilms() async {
    setState(() => isLoading = true);

    films = await FilmDatabase.instance.readAllFilms();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Film List'),
        ),
        body: isLoading
            ? const Text('Loading...')
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                child: Column(
                    children: List.generate(films.length, (index) {
                  final film = films[index];
                  return GestureDetector(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FilmDetailPage(filmId: film.id!),
                        ));

                        refreshFilms();
                      },
                      child: FilmCardWidget(film: film));
                }))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddFilmPage()),
              );
            }),
      );
}
