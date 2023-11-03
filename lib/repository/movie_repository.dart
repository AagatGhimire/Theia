import 'package:dio/dio.dart';
import 'package:theia/config.dart';
import 'package:theia/services/genre_response.dart';
import 'package:theia/services/movie_detail_response.dart';
import 'package:theia/services/movie_response.dart';

class MovieRepository {
  final String apiKey = myApiKey;
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getTopRatedMoviesUrl = '$mainUrl/movie/top_rated';
  var getNowPlayingMoviesUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';

  Future<MovieResponse> getMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
    };
    try {
      Response response =
          await _dio.get(getTopRatedMoviesUrl, queryParameters: params);

      return MovieResponse.fromJson(response.data);
    } on Exception catch (e) {
      print('Error in fetching: $e');
      return MovieResponse.withError('$e');
    }
  }

  Future<MovieResponse> getNowPlayingMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
    };
    try {
      Response response =
          await _dio.get(getNowPlayingMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } on Exception catch (e) {
      print('Error in fetching now playing movies: $e');
      return MovieResponse.withError('$e');
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      'with_genres': id,
    };
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } on Exception catch (e) {
      print('Error in fetching movies by genre: $e');
      return MovieResponse.withError('$e');
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
    };
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } on Exception catch (e) {
      print('Error in fetching genres: $e');
      return GenreResponse.withError('$e');
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
          await _dio.get("$getMoviesUrl/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } on Exception catch (e) {
      print('Error in fetching genres: $e');
      return MovieDetailResponse.withError('$e');
    }
  }
}
