import 'package:dio/dio.dart';
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

  final String apiKey = Keys.TMDB_API_KEY;

  var getPopularMoviesURL = URLs.popularMoviesEndPoint;
  Future<PopularMoviesRS> getPopularMovies({int page}) async {
    print("gtPopularMovies called!!!!");
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
    print("getGenres called!!!!");
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

  Future<PersonResponse> getPersons() async {
    print("getPersons called!!!!");
    var params = {"api_key": apiKey};

    try {
      Response response =
          await _dio.get(URLs.personsEndPoint, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getPersons: ", "$err");
      return PersonResponse.withError("$err");
    }
  }

  Future<PopularMoviesRS> getMoviesByGenre(int id) async {
    print("getPersons called!!!!");
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id,
    };

    try {
      Response response =
          await _dio.get(URLs.getMoviesEndPoint, queryParameters: params);
      return PopularMoviesRS.fromJson(response.data);
    } catch (err) {
      Log.n("Error_getPersons: ", "$err");
      return PopularMoviesRS.withError("$err");
    }
  }
}
