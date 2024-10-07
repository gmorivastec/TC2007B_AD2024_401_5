import 'dart:convert';

import 'package:flutter/material.dart';
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

// the same as in typescript, python, kotlin, etc 
// you can declare a method beyond the scope of a class
// making it available to anyone

// Future - similar to "Promise"
// type that works as a placeholder for a value that will be solved
// in the future
Future<List<Car>> getCars() async {

  final response = await http.get(
    Uri.parse("https://bitbucket.org/itesmguillermorivas/partial2/raw/45f22905941b70964102fce8caf882b51e988d23/carros.json")
  );

  if(response.statusCode == 200) {

    // if everything was fine return the list of cars
    List<dynamic> jsonResult = jsonDecode(response.body);
    List<Car> cars = [];

    for (var current in jsonResult){
      Car currentCar = Car.fromJSON(current);
      cars.add(currentCar);
    }

    return cars;
  } else {
    throw Exception("REQUEST HAD ERRORS: ${response.statusCode}");
  }

}

class RequestDetailWidget extends StatefulWidget {
  const RequestDetailWidget({super.key});

  @override
  State<RequestDetailWidget> createState() => _RequestDetailWidgetState();
}

class _RequestDetailWidgetState extends State<RequestDetailWidget> {

  // similar to kotlin we can specify an attribute that will be solved later
  late Future<List<Car>> cars;

  @override
  void initState() {
    super.initState();
    cars = getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DETAIL WITH REQUEST")),
      body: Center(
        // FutureBuilder - 
        // a widget that waits for a future to be solved
        // in order to display something
        child: FutureBuilder(
          future: cars, 
          builder: (context, snapshot) {
            if(snapshot.hasData){
              // if we get here the future was solved 
              // we can actually use its data to display stuff
              List<Widget> result = [];

              if(snapshot.data != null){
                for(var currentCar in snapshot.data!){
                  result.add(
                    Text(
                      "${currentCar.brand} ${currentCar.model} ${currentCar.year}"
                    )
                  );
                }
              }

              return Column(children: result,);

            } else if(snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // if we fall here it means future hasn't been solved yet
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}