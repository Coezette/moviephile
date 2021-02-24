import 'package:equatable/equatable.dart';
import 'package:moviephile/models/person.dart';

class CastResponse extends Equatable {
  final List<Actor> cast;
  final String error;

  CastResponse(this.cast, this.error);

  @override
  List<Object> get props => [cast, error];

  CastResponse.fromJson(Map<String, dynamic> json)
      : cast =
            (json["cast"] as List).map((e) => new Actor.fromJson(e)).toList(),
        error = "";

  CastResponse.withError(String errorVal)
      : cast = [],
        error = errorVal;
}
