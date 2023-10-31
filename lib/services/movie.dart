import 'package:flutter/material.dart';

@immutable
class Movie {
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;

  const Movie({
    required this.id,
    required this.popularity,
    required this.title,
    required this.backPoster,
    required this.poster,
    required this.overview,
    required this.rating,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        title = json['title'],
        backPoster = json['backdrop_path'],
        poster = json['poster_path'],
        overview = json['overview'],
        rating = json['vote_average'].toDouble();
}
