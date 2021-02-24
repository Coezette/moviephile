import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:moviephile/models/popular_movies_rs.dart';

class Utils {
  static bool shouldLog = true;
}

///Base URL and endpoints
class URLs {
  static const String TMBD_URL = "https://api.themoviedb.org/3";

  /// Endpoints for the different API calls
  static const String genresEndPoint = "$TMBD_URL/genre/movie/list";
  static const String personsEndPoint = "$TMBD_URL/trending/person/week";
  static const String getMoviesEndPoint = "$TMBD_URL/discover/movie";
  static const String popularMoviesEndPoint = "$TMBD_URL/movie/popular";
  static const String nowPlayingEndPoint = "$TMBD_URL/movie/now_playing";
}

class AppColorCodes {
  static Color mainTextColor = Colors.black;
  static Color textLightColor = Colors.black.withOpacity(0.2);
  static Color pageBackgroundColor = Colors.white;
  static Color primaryColor = Colors.blue;
}

///Class to help with manual console logging of responses
class Log {
  static s(String f, dynamic msg, {String tag = "‼STRONG‼"}) {
    if (Utils.shouldLog) {
      log("‼️ $tag, $f, $msg ️‼️");
    } else {}
  }

  static e(String f, dynamic msg, {String tag = "❗EMPHASIZE❗"}) {
    if (Utils.shouldLog) {
      log("❗️️ $tag, $f, $msg ❗️");
    } else {}
  }

  static n(String f, dynamic msg, {String tag = "NORMAL"}) {
    if (Utils.shouldLog) {
      log("$tag, $f, $msg");
    } else {}
  }

  static j(String f, dynamic msg, {String tag = "JSON"}) {
    if (Utils.shouldLog) {
      log("$tag, $f, ${jsonEncode(msg)}");
    } else {}
  }
}

///Fake responses to help with mocking objects and performing tests
class FakeResponse {
  static String popularMovies = jsonEncode({
    "page": 1,
    "total_results": 19772,
    "total_pages": 989,
    "results": [
      {
        "vote_count": 6503,
        "id": 299536,
        "video": false,
        "vote_average": 8.3,
        "title": "Avengers: Infinity War",
        "popularity": 350.154,
        "poster_path": "\/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
        "original_language": "en",
        "original_title": "Avengers: Infinity War",
        "genre_ids": [12, 878, 14, 28],
        "backdrop_path": "\/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
        "adult": false,
        "overview":
            "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
        "release_date": "2018-04-25"
      }
    ]
  });

  static String genresList = jsonEncode({
    "genres": [
      {"id": 28, "name": "Action"},
      {"id": 12, "name": "Adventure"},
      {"id": 16, "name": "Animation"},
      {"id": 35, "name": "Comedy"},
      {"id": 80, "name": "Crime"},
      {"id": 99, "name": "Documentary"},
      {"id": 18, "name": "Drama"},
      {"id": 10751, "name": "Family"},
      {"id": 14, "name": "Fantasy"},
      {"id": 36, "name": "History"},
      {"id": 27, "name": "Horror"},
      {"id": 10402, "name": "Music"},
      {"id": 9648, "name": "Mystery"},
      {"id": 10749, "name": "Romance"},
      {"id": 878, "name": "Science Fiction"},
      {"id": 10770, "name": "TV Movie"},
      {"id": 53, "name": "Thriller"},
      {"id": 10752, "name": "War"},
      {"id": 37, "name": "Western"}
    ]
  });

  static String moviesInGenre = jsonEncode({
    "page": 1,
    "results": [
      {
        "adult": false,
        "backdrop_path": "/8tNX8s3j1O0eqilOQkuroRLyOZA.jpg",
        "genre_ids": [14, 28, 12],
        "id": 458576,
        "original_language": "en",
        "original_title": "Monster Hunter",
        "overview":
            "A portal transports Lt. Artemis and an elite unit of soldiers to a strange world where powerful monsters rule with deadly ferocity. Faced with relentless danger, the team encounters a mysterious hunter who may be their only hope to find a way home.",
        "popularity": 3339.185,
        "poster_path": "/uwjaCH7PiWrkz7oWJ4fcL3xGrb0.jpg",
        "release_date": "2020-12-03",
        "title": "Monster Hunter",
        "video": false,
        "vote_average": 7.2,
        "vote_count": 637
      },
      {
        "adult": false,
        "backdrop_path": "/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
        "genre_ids": [14, 28, 12],
        "id": 464052,
        "original_language": "en",
        "original_title": "Wonder Woman 1984",
        "overview":
            "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
        "popularity": 1825.184,
        "poster_path": "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
        "release_date": "2020-12-16",
        "title": "Wonder Woman 1984",
        "video": false,
        "vote_average": 6.9,
        "vote_count": 3838
      },
    ],
    "total_pages": 500,
    "total_results": 10000
  });

  static String cast = jsonEncode({
    "id": 649087,
    "cast": [
      {
        "adult": false,
        "gender": 2,
        "id": 116614,
        "known_for_department": "Acting",
        "name": "Johannes Bah Kuhnke",
        "original_name": "Johannes Bah Kuhnke",
        "popularity": 1.61,
        "profile_path": "/q9xNsXwP1LBnOR8m251O86Uvl36.jpg",
        "cast_id": 4,
        "character": "Einar",
        "credit_id": "5fc5055bd2f5b50040d994d4",
        "order": 1
      },
      {
        "adult": false,
        "gender": 1,
        "id": 1309110,
        "known_for_department": "Acting",
        "name": "Nanna Blondell",
        "original_name": "Nanna Blondell",
        "popularity": 0.766,
        "profile_path": "/llxgGKg9MtCu4v7fT93FPvhfZhI.jpg",
        "cast_id": 5,
        "character": "Nadja",
        "credit_id": "5fc505630328b9003f6bf086",
        "order": 2
      },
    ]
  });

  static String nowPlaying = jsonEncode({
    "dates": {"maximum": "2021-02-22", "minimum": "2021-01-05"},
    "page": 1,
    "results": [
      {
        "adult": false,
        "backdrop_path": "/8tNX8s3j1O0eqilOQkuroRLyOZA.jpg",
        "genre_ids": [14, 28, 12],
        "id": 458576,
        "original_language": "en",
        "original_title": "Monster Hunter",
        "overview":
            "A portal transports Lt. Artemis and an elite unit of soldiers to a strange world where powerful monsters rule with deadly ferocity. Faced with relentless danger, the team encounters a mysterious hunter who may be their only hope to find a way home.",
        "popularity": 3339.185,
        "poster_path": "/uwjaCH7PiWrkz7oWJ4fcL3xGrb0.jpg",
        "release_date": "2020-12-03",
        "title": "Monster Hunter",
        "video": false,
        "vote_average": 7.2,
        "vote_count": 637
      },
      {
        "adult": false,
        "backdrop_path": "/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
        "genre_ids": [14, 28, 12],
        "id": 464052,
        "original_language": "en",
        "original_title": "Wonder Woman 1984",
        "overview":
            "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
        "popularity": 1825.184,
        "poster_path": "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
        "release_date": "2020-12-16",
        "title": "Wonder Woman 1984",
        "video": false,
        "vote_average": 6.9,
        "vote_count": 3838
      },
    ],
    "total_pages": 40,
    "total_results": 782
  });

  static String movieItemString = jsonEncode({
    "popularity": 3339.185,
    "vote_count": 637,
    "video": false,
    "poster_path": "/uwjaCH7PiWrkz7oWJ4fcL3xGrb0.jpg",
    "id": 458576,
    "adult": false,
    "backdrop_path": "/8tNX8s3j1O0eqilOQkuroRLyOZA.jpg",
    "original_language": "en",
    "original_title": "Monster Hunter",
    "genre_ids": [14, 28, 12],
    "title": "Monster Hunter",
    "vote_average": 7.2,
    "overview":
        "A portal transports Lt. Artemis and an elite unit of soldiers to a strange world where powerful monsters rule with deadly ferocity. Faced with relentless danger, the team encounters a mysterious hunter who may be their only hope to find a way home.",
    "release_date": "2020-12-03"
  });
  static MovieModel movieItemSingle =
      MovieModel.fromJson(jsonDecode(movieItemString));
}
