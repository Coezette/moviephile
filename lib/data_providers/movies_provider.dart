import 'package:dio/dio.dart';
import 'package:moviephile/globals/keys.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/popular_movies_rs.dart';

class MoviesProvider {
//  Future<RawData> readData() async {
//    // Read from DB or make network request etc...
//  }
  final Dio _dio = Dio();

  final String apiKey = Keys.TMDB_API_KEY;
  static String tmdbURL = Utils.TMBD_URL;

  var getPopularMoviesURL = "$tmdbURL/movie/popular";

  Future<PopularMoviesRS> getPopularMovies({int page}) async {
    print("gtPopularMovies called!!!!");
    var params = {"api_key": apiKey, "language": "en-US", "page": page};

    Response response =
        await _dio.get(getPopularMoviesURL, queryParameters: params);
//    print("result from _dio: ${response.data}");
    return PopularMoviesRS.fromJson(response.data);
//    try {
//      Response response =
//          await _dio.get(getPopularMoviesURL, queryParameters: params);
//      return PopularMoviesRS.fromJson(response.data);
//    } catch (err) {
//      print("Error: $err");
//      //TODO: implement and return a .withError
//    }
  }
}
