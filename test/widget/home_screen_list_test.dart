import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/screens/home_screen.dart';
import 'package:moviephile/states/popular_movies_state.dart';

class MockPopularMoviesBloc extends MockBloc<PopularMoviesState>
    implements PopularMoviesBloc {}

void main() {
  final popularMoviesBloc = MockPopularMoviesBloc();
  var movieItemExample = FakeResponse.movieItemSingle;

  whenListen<PopularMoviesState>(
      popularMoviesBloc,
      Stream.fromIterable(<PopularMoviesState>[
        PopularMoviesInitial(),
        PopularMoviesSuccess(),
      ]));

  testWidgets(
      "Testing that the ListView appears when HomeScreen is Initialized",
      (tester) async {
    await tester.pumpWidget(
      BlocProvider<PopularMoviesBloc>.value(
        value: popularMoviesBloc,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MovieWidget(movie: movieItemExample),
        ),
      ),
    );

    await expectLater(popularMoviesBloc.state, equals(PopularMoviesSuccess()));
  }, skip: true); //TODO: Revisit this test
}
