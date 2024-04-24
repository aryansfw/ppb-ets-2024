const String tableFilms = 'films';

class FilmFields {
  static final List<String> values = [id, title, description, imageUrl, time];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String imageUrl = 'imageUrl';
  static const String time = 'time';
}

class Film {
  final int? id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdTime;

  Film(
      {this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.createdTime});

  Film copy({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    DateTime? createdTime,
  }) =>
      Film(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        createdTime: createdTime ?? this.createdTime,
      );

  static Film fromJson(Map<String, Object?> json) => Film(
        id: json[FilmFields.id] as int?,
        title: json[FilmFields.title] as String,
        description: json[FilmFields.description] as String,
        imageUrl: json[FilmFields.imageUrl] as String,
        createdTime: DateTime.parse(json[FilmFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        FilmFields.id: id,
        FilmFields.title: title,
        FilmFields.description: description,
        FilmFields.imageUrl: imageUrl,
        FilmFields.time: createdTime.toIso8601String(),
      };
}
