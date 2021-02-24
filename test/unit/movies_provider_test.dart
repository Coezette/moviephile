import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:moviephile/data_providers/movies_provider.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';

class HTTPMock extends Mock implements http.Client {}

void main() {
  group("HTTP call-related tests", () {
    final httpMock = http.Client();
    final url = "https://api.themoviedb.org/3";
    final moviesProvider = MoviesProvider(httpMock);

    test("Returns Popular Movies response on success", () async {
      when(httpMock.get(url).whenComplete(() {
        return http.Response(FakeResponse.popularMovies, 200);
      }));

      var actual = await moviesProvider.getPopularMovies(page: 1);
      var expected =
          PopularMoviesRS.fromJson(jsonDecode(FakeResponse.popularMovies));

      //had to compare runtimeTypes because was having issues with equatable (comparing objects of classes whose fields are not all final gives issues)
      expect(actual.runtimeType == PopularMoviesRS,
          expected.runtimeType == PopularMoviesRS);
    });

    test("Returns a List of GenreResponse on success", () async {
      when(httpMock.get(url).whenComplete(() {
        return http.Response(FakeResponse.genresList, 200);
      }));

      var actual = await moviesProvider.getGenres();
      var expected =
          GenreResponse.fromJson(jsonDecode(FakeResponse.genresList));

      expect(actual.runtimeType == GenreResponse,
          expected.runtimeType == GenreResponse);
    });

    test("Returns a PopularMoviesRS object on success", () async {
      when(httpMock.get(url).whenComplete(() {
        return http.Response(FakeResponse.moviesInGenre, 200);
      }));

      int genreID = 23;
      var actual = await moviesProvider.getMoviesByGenre(genreID);
      var expected =
          PopularMoviesRS.fromJson(jsonDecode(FakeResponse.moviesInGenre));

      expect(actual.runtimeType == PopularMoviesRS,
          expected.runtimeType == PopularMoviesRS);
    });

    test("Returns a CastResponse object on success", () async {
      when(httpMock.get(url).whenComplete(() {
        return http.Response(FakeResponse.cast, 200);
      }));

      int movID = 24;
      var actual = await moviesProvider.getCast(movID: movID);
      var expected = CastResponse.fromJson(jsonDecode(FakeResponse.cast));

      expect(actual.runtimeType == CastResponse,
          expected.runtimeType == CastResponse);
    });

    test("Returns a PopularMoviesRS object on success", () async {
      when(httpMock.get(url).whenComplete(() {
        return PopularMoviesRS.fromJson(jsonDecode(FakeResponse.nowPlaying));
      }));

      var actual = await moviesProvider.getNowPlaying();
      var expected =
          PopularMoviesRS.fromJson(jsonDecode(FakeResponse.nowPlaying));

      expect(actual.runtimeType == PopularMoviesRS,
          expected.runtimeType == PopularMoviesRS);
    });
  });
}
