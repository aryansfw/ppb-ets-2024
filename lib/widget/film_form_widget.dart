import 'package:flutter/material.dart';

class FilmFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedImageUrl;
  final VoidCallback onSubmit;

  const FilmFormWidget({
    super.key,
    this.title = '',
    this.description = '',
    this.imageUrl = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedImageUrl,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Column(children: <Widget>[
        buildTitle(),
        buildDescription(),
        buildImageUrl(),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(onPressed: onSubmit, child: const Text('Save'))
      ]));

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          hintText: 'Enter the film\'s title',
          labelText: 'Title',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );
  Widget buildDescription() => TextFormField(
        minLines: 1,
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          hintText: 'Enter the film\'s description',
          labelText: 'Description',
        ),
        validator: (description) {
          if (description != null && description.isEmpty) {
            return 'The description cannot be empty';
          }
          return null;
        },
        onChanged: onChangedDescription,
      );
  Widget buildImageUrl() => TextFormField(
        maxLines: 1,
        initialValue: imageUrl,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: const InputDecoration(
          hintText: 'Enter the film\'s cover URL',
          labelText: 'Cover URL',
        ),
        validator: (coverUrl) {
          if (coverUrl != null && coverUrl.isEmpty) {
            return 'The cover URL cannot be empty';
          }

          if (coverUrl != null && !Uri.parse(coverUrl).isAbsolute) {
            return 'The cover URL is invalid';
          }
          return null;
        },
        onChanged: onChangedImageUrl,
      );
}
