import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:moviephile/globals/keys.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';

class MoviesProvider {
  final http.Client _client;

  MoviesProvider(this._client);

  ///REPLACE with own API
  final String apiKey = Keys.TMDB_API_KEY;

  ///Call to get list of Popular Movies
  var getPopularMoviesURL = URLs.popularMoviesEndPoint;
  Future<PopularMoviesRS> getPopularMovies({int page}) async {
//    Log.n("gtPopularMovies_called", "called");

    try {
      final response =
          await _client.get("$getPopularMoviesURL?api_key=$apiKey&page=$page");

      return PopularMoviesRS.fromJson(jsonDecode(response.body));
    } catch (err) {
      Log.n("Error_getPopularMovies: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }

  ///Call to get list of Movies Genres
  Future<GenreResponse> getGenres() async {
//    Log.n("getGenres_called", "called");

    try {
      final response =
          await _client.get("${URLs.genresEndPoint}?api_key=$apiKey");

      return GenreResponse.fromJson(jsonDecode(response.body));
    } catch (err) {
      Log.n("Error_getGenres: ", "$err");
      return GenreResponse.withError("$err");
    }
  }

  ///Call to get list of Movies within a particular Genre
  Future<PopularMoviesRS> getMoviesByGenre(int id) async {
    try {
      final response = await _client
          .get("${URLs.getMoviesEndPoint}?api_key=$apiKey&with_genres=$id");
      return PopularMoviesRS.fromJson(jsonDecode(response.body));
    } catch (err) {
      Log.n("Error_getMoviesByGenre: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }

  ///Call to get Movie Cast
  Future<CastResponse> getCast({@required int movID}) async {
    try {
      final response = await _client
          .get("${URLs.TMBD_URL}/movie/$movID/credits?api_key=$apiKey");

      return CastResponse.fromJson(jsonDecode(response.body));
    } catch (err) {
      Log.n("Error_getCast: ", "$err");
      return CastResponse.withError("$err");
    }
  }

  ///Call to get list of Movies Now-Playing in Cinemas
  Future<PopularMoviesRS> getNowPlaying() async {
    try {
      final response =
          await _client.get("${URLs.nowPlayingEndPoint}?api_key=$apiKey");
//      Log.n("getNowPlaying_call_Response", response.body);

      return PopularMoviesRS.fromJson(jsonDecode(response.body));
    } catch (err) {
      Log.n("Error_getNowPlaying: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }
}
