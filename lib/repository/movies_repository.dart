import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:moviephile/data_providers/movies_provider.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';

class MoviesRepository {
  static final _client = http.Client();

  final MoviesProvider moviesProvider = MoviesProvider(_client);

  ///initiating the API call to get popular movies (implementation in the MoviesProvider)
  Future<PopularMoviesRS> getPopularMovies({@required int page}) async {
    final PopularMoviesRS _popularMoviesRS =
        await moviesProvider.getPopularMovies(page: page);
//    print("repo is updated: ${_popularMoviesRS.page}");
    return _popularMoviesRS;
  }

  ///initiating the API call to get movies Genres
  Future<GenreResponse> getGenres() async {
    final GenreResponse response = await moviesProvider.getGenres();
    return response;
  }

  ///initiating the API call to get Now-Playing movies
  Future<PopularMoviesRS> getNowPlaying() async {
    final PopularMoviesRS response = await moviesProvider.getNowPlaying();
    return response;
  }

  ///initiating the API call to get movies in each Genre
  Future<PopularMoviesRS> getMoviesByGenre(int id) async {
    final PopularMoviesRS response = await moviesProvider.getMoviesByGenre(id);
    return response;
  }

  ///initiating the API call to get cast of a movies
  Future<CastResponse> getCast({@required int movID}) async {
    final CastResponse response = await moviesProvider.getCast(movID: movID);
    return response;
  }
}
