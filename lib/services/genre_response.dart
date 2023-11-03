import 'package:theia/services/genre.dart';

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse(
    this.genres,
    this.error,
  );

  // factory method to create a GenreResponse instance from JSON data recieved
  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres = (json["genres"] as List)
            .map((genre) => Genre.fromJson(genre))
            .toList(), // parse and store genre data from JSON
        error = ""; // initialize error message as empty for successful response

  // facory method to create a GenreResponse instance with error message
  GenreResponse.withError(String errorValue)
      : genres = [], // initialize genres list as empty for error response
        error = errorValue;
}
