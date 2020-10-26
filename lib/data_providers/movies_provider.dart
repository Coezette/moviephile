import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moviephile/globals/keys.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';

class MoviesProvider {
//  Future<RawData> readData() async {
//    // Read from DB or make network request etc...
//  }
  final Dio _dio = Dio();

  final String apiKey = Keys.TMDB_API_KEY; //replace this with your own API key

  var getPopularMoviesURL = URLs.popularMoviesEndPoint;
  Future<PopularMoviesRS> getPopularMovies({int page}) async {
    Log.n("gtPopularMovies_called", "called");
    var params = {"api_key": apiKey, "language": "en-US", "page": page};

    try {
      Response response =
          await _dio.get(getPopularMoviesURL, queryParameters: params);
      return PopularMoviesRS.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getPopularMovies: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }

  Future<GenreResponse> getGenres() async {
    Log.n("getGenres_called", "called");
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response =
          await _dio.get(URLs.genresEndPoint, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getGenres: ", "$err");
      return GenreResponse.withError("$err");
    }
  }

  Future<CastResponse> getCast({@required int movID}) async {
    Log.n("getCast_called", "called");
    var params = {"api_key": apiKey, "movie_id": movID};

    try {
//      Log.n("Error_getCast_request_sent: ", "${URLs.TMBD_URL}/credit/{$movID}");

      Response response = await _dio.get(
          "${URLs.TMBD_URL}/movie/$movID/credits",
          queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getCast: ", "$err");
      return CastResponse.withError("$err");
    }
  }

  Future<PopularMoviesRS> getMoviesByGenre(int id) async {
//    Log.n("getMoviesByGenre:", "called");
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id,
    };

    try {
      //TODO: add right endpoint for this
      Response response =
          await _dio.get(URLs.getMoviesEndPoint, queryParameters: params);
      return PopularMoviesRS.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getMoviesByGenre: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }

  Future<PopularMoviesRS> getNowPlaying() async {
    Log.n("getNowPlaying_called", "yes");
    var params = {"api_key": apiKey};

    try {
      Response response =
          await _dio.get(URLs.nowPlayingEndPoint, queryParameters: params);
      return PopularMoviesRS.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getNowPlaying: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }
}
