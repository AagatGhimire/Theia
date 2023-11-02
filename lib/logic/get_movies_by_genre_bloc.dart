import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:theia/repository/movie_repository.dart';
import 'package:theia/services/movie_response.dart';

class MovieListByGenreBloc {
  final MovieRepository _repository = MovieRepository();

  // hold and stream MovieResponse objects
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  // method to fetch movie by a specific genre
  getMoviesByGenre(int id) async {
    MovieResponse response = await _repository.getMovieByGenre(id);

    // add fetched movie to the subject for streaming to subscribers
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  // subclasses that override dispose should call super.dispose() for proper cleanup
  @mustCallSuper
  void dispose() async {
    await _subject.drain(); // clear subject stream
    _subject.close(); // close subject
  }

  // getter to access subject from outside the class
  BehaviorSubject<MovieResponse> get subject => _subject;
}

// global instance of MovieListByGenreBloc
final movieListByGenreBloc = MovieListByGenreBloc();
