import 'package:flutter/material.dart';
import 'package:ppb_ets_2024/db/film_database.dart';
import 'package:ppb_ets_2024/model/film.dart';
import 'package:ppb_ets_2024/widget/film_form_widget.dart';

class AddFilmPage extends StatefulWidget {
  final Film? film;
  const AddFilmPage({super.key, this.film});

  @override
  State<AddFilmPage> createState() => _AddFilmPageState();
}

class _AddFilmPageState extends State<AddFilmPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String imageUrl;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.film?.title ?? '';
    imageUrl = widget.film?.imageUrl ?? '';
    description = widget.film?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Add Film')),
        body: Form(
          key: _formKey,
          child: FilmFormWidget(
            title: title,
            imageUrl: imageUrl,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedImageUrl: (imageUrl) =>
                setState(() => this.imageUrl = imageUrl),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onSubmit: addFilm,
          ),
        ),
      );

  Future addFilm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final film = Film(
        title: title,
        description: description,
        imageUrl: imageUrl,
        createdTime: DateTime.now(),
      );

      await FilmDatabase.instance.create(film);

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future updateFilm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final note = widget.film!.copy(
        title: title,
        description: description,
        imageUrl: imageUrl,
      );

      await FilmDatabase.instance.update(note);

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
