// import works in a similar fashion to react native (and everywhere else)
import 'package:flutter/material.dart';

// we have a very explicit entry point in our flutter app
// there IS a main method available for us! 
void main() {
  // inflates widget and attaches it to view
  // inflates???!?!?
  // - building an interface and creating an object based on that description
  runApp(const MainApp());
}

// Widget:
// Very similar to "component" and "composable"
// the basic building block for UI in Flutter

// Widgets can aggregate - build new widgets with smaller widgets 
// a widget class MUST extend another widget class

// each widget is defined by its own class
// super important - they must have a build method somewhere

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    // the build method MUST return a widget
    // constant constructor are prefered for performance reasons
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Guys!'),
        ),
      ),
    );
  }
}
