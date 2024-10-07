import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './request.dart';


// 2 MAIN TYPES OF WIDGETS
// 1. stateful
// 2. stateless

// stateless - type of widget in which the main interface doesn't chage 
// doesn't matter what happens with data (has no state)

class StatelessExample extends StatelessWidget {
  const StatelessExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HEY GUYS, I'M AN APP BAR."),
      ),
      // this is going to be an example 
      // 1. of a column 
      // 2. an example of a widget that cannot use a const constructor
      body: const StatefulExample()
      /*
      Column(
        children: [
          const Text("HEY GUYS"),
          const Text("THIS IS AN EXAMPLE"),
          const Text("OF A COLUMN!"),
          Image.network("https://www.isabeleats.com/wp-content/uploads/2020/11/chilaquiles-verdes-small-8-127x191.jpg")
        ],
      )*/
    );
  }
}

// stateful widget 
// 1. can have several different UIs associated 
// with a state 
// 2. can use state variables 
class StatefulExample extends StatefulWidget {
  const StatefulExample({super.key});

  // required - have a create state method
  // MUST return a state for this particular type
  // this method should have the logic to determine what state to return
  @override
  State<StatefulExample> createState() => _StatefulExampleState();
}

// states MUST extend state with the associated widget as type argument
class _StatefulExampleState extends State<StatefulExample> {

  // for this example we are going to displaya list with predefined data
  final List<String> content = ["a", "b", "c", "d", "e"];
  final TextStyle textStyle = const TextStyle(fontSize: 20.0);

  // states MUST override the build method 
  // does the same as the build method in the stateless widget
  @override
  Widget build(BuildContext context) {
    return buildList();
  }

  // remember: we are coding a class 
  // we have the ability to declare members - variables, methods
  Widget buildList() {

    // we are using a design pattern here
    // which one is it?
    // - factory
    // https://en.wikipedia.org/wiki/Factory_method_pattern
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: content.length,
      itemBuilder: (context, i) {
        return buildRow(content[i]);
      },
    );
  }

  Widget buildRow(String value) {
    return ListTile(
      title: Text(
          value,
          style: textStyle,
        ),
      onTap: () {
        Fluttertoast.showToast(
          msg: "YOU TOUCHED A TILE! $value",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
        );

        Navigator.push(
          context, 
          /*
          MaterialPageRoute(builder: (context) => DetailView(
            externalArg: value,))*/
          MaterialPageRoute(builder: (context) => const RequestDetailWidget())
        );
      },
    );
  }
}

// let's do a detail view we can navigate to
class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.externalArg});

  final String externalArg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DETAIL VIEW")),
      body: Center(
        child: Text("SOME INFO TO DISPLAY: $externalArg")
      )
    );
  }
}