import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/screens/categories_screen.dart';
import 'package:moviephile/screens/home_screen.dart';
import 'package:moviephile/states/popular_movies_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _screenNumber = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc(PopularMoviesInitial())
        ..add(FetchPopularMoviesEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: navItems[_screenNumber].screen,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: navItems
                .map((navItem) => BottomNavigationBarItem(
                      icon: navItem.navIcon,
                      label: navItem.title,
                    ))
                .toList(),
            currentIndex: _screenNumber,
            onTap: (i) => setState(() {
              _screenNumber = i;
            }),
          ),
        ),
      ),
    );
  }
}

class NavObject {
  Widget screen;
  Icon navIcon;
  String title;
  NavObject({this.screen, this.navIcon, this.title});
}

List<NavObject> navItems = [
  NavObject(
    screen: HomeScreen(),
    navIcon: Icon(Icons.home),
    title: "All Movies",
  ),
  NavObject(
    screen: CategoriesScreen(),
    navIcon: Icon(Icons.category),
    title: "Categories",
  ),
];
