import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moviephile/data_providers/movies_provider.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:http/http.dart' as http;

class MoviesRepository {
  ///Alternatively use BaseOptions for better readability
  static final _client = http.Client();

  final MoviesProvider moviesProvider = MoviesProvider(_client);

  Future<PopularMoviesRS> getPopularMovies({@required int page}) async {
    final PopularMoviesRS _popularMoviesRS =
        await moviesProvider.getPopularMovies(page: page);
    print("repo is updated: ${_popularMoviesRS.page}");
    return _popularMoviesRS;
  }

  Future<GenreResponse> getGenres() async {
    final GenreResponse response = await moviesProvider.getGenres();
    return response;
  }

  Future<PopularMoviesRS> getNowPlaying() async {
    final PopularMoviesRS response = await moviesProvider.getNowPlaying();
    return response;
  }

  Future<PopularMoviesRS> getMoviesByGenre(int id) async {
    final PopularMoviesRS response = await moviesProvider.getMoviesByGenre(id);
    return response;
  }

  Future<CastResponse> getCast({@required int movID}) async {
    final CastResponse response = await moviesProvider.getCast(movID: movID);
    return response;
  }
}
