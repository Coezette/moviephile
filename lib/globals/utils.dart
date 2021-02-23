import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';

class Utils {
  static bool shouldLog = true;
//  static AppColorCodes myColor;
}

class URLs {
  static const String TMBD_URL = "https://api.themoviedb.org/3";

  //endpoints
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
}
