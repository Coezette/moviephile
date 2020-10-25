import 'package:moviephile/models/person.dart';

class CastResponse {
  final List<Actor> cast;
  final String error;

  CastResponse(this.cast, this.error);

  CastResponse.fromJson(Map<String, dynamic> json)
      : cast =
            (json["cast"] as List).map((e) => new Actor.fromJson(e)).toList(),
        error = "";

  CastResponse.withError(String errorVal)
      : cast = List(),
        error = errorVal;
}
