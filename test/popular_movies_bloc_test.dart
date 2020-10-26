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

class MockMoviesRepository extends Mock implements MoviesRepository {
/*
  @override
  Future<CastResponse> getCast({int movID}) {
    // TODO: implement getCast
    throw UnimplementedError();
  }

  @override
  Future<GenreResponse> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<PopularMoviesRS> getMoviesByGenre(int id) {
    // TODO: implement getMoviesByGenre
    throw UnimplementedError();
  }

  @override
  Future<PopularMoviesRS> getNowPlaying() {
    // TODO: implement getNowPlaying
    throw UnimplementedError();
  }

  @override
  Future<PopularMoviesRS> getPopularMovies({int page}) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  // TODO: implement moviesProvider
  MoviesProvider get moviesProvider => throw UnimplementedError();
 */
}

void main() {
  MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
  });

  group("GetPopularMovies", () {
    final popularMoviesState = PopularMoviesSuccess(
        movies: [],
        popularMoviesRS: PopularMoviesRS(),
        hasReachedMax: false,
        page: 1);

//    blocTest(
//      "Outputs PopularMoviesSuccess when successful",
//      build: () {
//        when(mockMoviesRepository.getPopularMovies(page: 1))
//            .thenAnswer((_) async => popularMoviesState);
//        return PopularMoviesBloc(mockMoviesRepository);
//      },
//      act: (bloc) => bloc.add(FetchPopularMoviesEvent),
//      expect: [PopularMoviesSuccess()],
//    );

    //TODO: correct minor issues here
  });
}
