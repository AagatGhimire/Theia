import 'package:dio/dio.dart';
import 'package:theia/config.dart';
import 'package:theia/services/movie_response.dart';

class MovieRepository {
  final String apiKey = myApiKey;
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getTopRatedMoviesUrl = '$mainUrl/movie/top_rated';
  var getNowPlayingMoviesUrl = '$mainUrl/movie/now_playing';

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
}
