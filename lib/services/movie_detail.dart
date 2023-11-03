import 'package:theia/services/genre.dart';

class MovieDetail {
  final int? id;
  final bool? adult;
  final List<Genre>? genres;
  final String? releaseDate;
  final int? runTime;
  final int? budget;

  MovieDetail(
    this.id,
    this.adult,
    this.genres,
    this.releaseDate,
    this.runTime,
    this.budget,
  );

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        adult = json['adult'],
        genres = (json["genres"] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList(),
        releaseDate = json['release_date'],
        runTime = json['runtime'],
        budget = json['budget'];
}
