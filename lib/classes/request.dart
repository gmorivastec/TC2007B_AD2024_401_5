import 'package:http/http.dart' as http;

// let's do a request! 
// we need 2 things:
// 1. Define a class that wil lbe used to parse a JSON
// 2. actually do the HTTP request

// url - https://bitbucket.org/itesmguillermorivas/partial2/raw/45f22905941b70964102fce8caf882b51e988d23/carros.json

class Car {

  Car({required this.brand, required this.model, required this.year});

  final String brand;
  final String model;
  final int year;

  // we will define our very own factory method!! 
  // reason: we want to translate map into a Car object
  factory Car.fromJSON(Map<String, dynamic> json) {
    return Car(
      brand: json['marca'],
      model: json['modelo'],
      year: json['anio']
    );
  }
}