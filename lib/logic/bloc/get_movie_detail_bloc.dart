import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';
import 'package:theia/repository/movie_repository.dart';
import 'package:theia/services/movie_detail_response.dart';

class MovieDetailBloc {
  final MovieRepository _repository = MovieRepository();

  // hold and stream MovieResponse objects
  final BehaviorSubject<MovieDetailResponse> _subject =
      BehaviorSubject<MovieDetailResponse>();

  getMovieDetail(int id) async {
    MovieDetailResponse response = await _repository.getMovieDetail(id);

    // make response available to subscribers
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  // getter to access subject from outside the class
  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

// global instance of GenresListBloc
final movieDetailBloc = MovieDetailBloc();
