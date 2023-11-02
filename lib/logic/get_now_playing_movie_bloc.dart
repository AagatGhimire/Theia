import 'package:rxdart/rxdart.dart';
import 'package:theia/repository/movie_repository.dart';
import 'package:theia/services/movie_response.dart';

class NowPlayingMoviesListBloc {
  final MovieRepository _repository = MovieRepository();

  // hold and stream MovieResponse objects
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getNowPlayingMovies();

    // make response available to subscribers
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  // getter to access subject from outside the class
  BehaviorSubject<MovieResponse> get subject => _subject;
}

// global instance of NowPlayingMoviesListBloc
final nowPlayingMoviesBloc = NowPlayingMoviesListBloc();
