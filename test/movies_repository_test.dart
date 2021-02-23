import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/data_providers/movies_provider.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:moviephile/states/popular_movies_state.dart';

class MockPopularMoviesRS extends Mock implements PopularMoviesRS {}

class MockMoviesProvider extends Mock implements MoviesProvider {}

void main() {}
