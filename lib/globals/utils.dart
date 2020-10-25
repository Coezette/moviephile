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
