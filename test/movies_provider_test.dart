import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviephile/data_providers/movies_provider.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:http/http.dart' as http;

class HTTPMock extends Mock implements http.Client {}

void main() {
  test("Returns Popular Movies response on success", () async {
    final httpMock = http.Client();
    final url = "https://api.themoviedb.org/3";

    final moviesProvider = MoviesProvider(httpMock);

    when(httpMock.get(url).whenComplete(() {
      return http.Response(FakeResponse.popularMovies, 200);
    }));

    var actual = await moviesProvider.getPopularMovies(page: 1);

    expect(
      Future.value(actual.runtimeType == PopularMoviesRS),
      completion(equals(
          PopularMoviesRS.fromJson(jsonDecode(FakeResponse.popularMovies))
                  .runtimeType ==
              PopularMoviesRS)),
    );
  });
}
