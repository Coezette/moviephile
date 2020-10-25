import 'package:moviephile/models/person.dart';

class PersonResponse {
  final List<Person> people;
  final String error;

  PersonResponse(this.people, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : people = (json["genres"] as List)
            .map((e) => new Person.fromJson(e))
            .toList(),
        error = "";

  PersonResponse.withError(String errorVal)
      : people = List(),
        error = errorVal;
}
