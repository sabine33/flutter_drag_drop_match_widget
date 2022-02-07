import 'package:flutter/material.dart';

final items = [
  DragDropItem(
      key: "apple",
      value: "apple",
      dragChild: Text(
        "APPLE",
        style: TextStyle(fontSize: 30),
      ),
      dropChild: Text(
        "🍎",
        style: TextStyle(fontSize: 50),
      ),
      iconData: Icons.one_k),
  DragDropItem(
      key: "ball",
      value: "Ball",
      dragChild: Text(
        "BALL",
        style: TextStyle(fontSize: 30),
      ),
      dropChild: Text(
        "⚽",
        style: TextStyle(fontSize: 50),
      ),
      iconData: Icons.one_k),
  DragDropItem(
      key: "cat",
      value: "Cat",
      dragChild: Text(
        "CAT",
        style: TextStyle(fontSize: 30),
      ),
      dropChild: Text(
        "😺",
        style: TextStyle(fontSize: 50),
      ),
      iconData: Icons.one_k)
];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int score = 0;

  var matched = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Score $score"),
          ),
          body: DragDropWidget(
              items: items,
              onMatched: (DragDropItem? item) {
                score += 10;
                setState(() {});
                matched.add(item);
                if (matched.length == items.length) {
                  print("GAME OVER");
                }
              },
              onMisMatched: (DragDropItem? item) {
                print("Mismatched");

                print(item);
              }),
        )); //(title: 'Kids Games'),
    // );
  }
}
