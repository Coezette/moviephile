import 'package:flutter/material.dart';
import 'package:moviephile/data_providers/movies_provider.dart';
import 'package:moviephile/models/popular_movies_rs.dart';

class MoviesRepository {
  final MoviesProvider moviesProvider = MoviesProvider();

  Future<PopularMoviesRS> getPopularMovies({@required int page}) async {
    final PopularMoviesRS _popularMoviesRS =
        await moviesProvider.getPopularMovies(page: page);
    print("repo is updated: ${_popularMoviesRS.page}");
    return _popularMoviesRS;
  }
}
