import 'package:bloc_test/bloc_test.dart';

import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/states/popular_movies_state.dart';

void main() {
  blocTest(
    "Emits a PopularMoviesSuccess state in response to FetchPopularMoviesEvent",
    build: () => PopularMoviesBloc(PopularMoviesInitial()),
    act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
    expect: [PopularMoviesSuccess()],
  );
}
