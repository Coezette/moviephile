import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/screens/home_screen.dart';
import 'package:moviephile/states/popular_movies_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc(PopularMoviesInitial())
        ..add(FetchPopularMoviesEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
