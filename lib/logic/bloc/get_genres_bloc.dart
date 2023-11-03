import 'package:rxdart/rxdart.dart';
import 'package:theia/repository/movie_repository.dart';
import 'package:theia/services/genre_response.dart';

class GenresListBloc {
  final MovieRepository _repository = MovieRepository();

  // hold and stream MovieResponse objects
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _repository.getGenres();

    // make response available to subscribers
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  // getter to access subject from outside the class
  BehaviorSubject<GenreResponse> get subject => _subject;
}

// global instance of GenresListBloc
final genresBloc = GenresListBloc();
