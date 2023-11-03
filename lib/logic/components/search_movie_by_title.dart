import 'package:flutter/material.dart';
import 'package:theia/repository/movie_repository.dart';
import 'package:theia/services/movie.dart';
import 'package:theia/services/movie_response.dart';
import 'package:theia/view/movie_detail_page.dart';

class SearchMovieByTitleComponent extends StatefulWidget {
  const SearchMovieByTitleComponent({super.key});

  @override
  State<SearchMovieByTitleComponent> createState() =>
      _SearchMovieByTitleComponentState();
}

class _SearchMovieByTitleComponentState
    extends State<SearchMovieByTitleComponent> {
  final MovieRepository _repository = MovieRepository();
  TextEditingController searchController = TextEditingController();
  List<Movie> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search movie by title',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchMovie();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final movie = searchResult[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(movie.title),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void searchMovie() async {
    final query = searchController.text;
    if (query.isNotEmpty) {
      MovieResponse response = await _repository.searchMoviesByTitle(query);
      setState(() {
        searchResult = response.movies;
      });
    } else {
      setState(() {
        searchResult = [];
      });
    }
  }
}
