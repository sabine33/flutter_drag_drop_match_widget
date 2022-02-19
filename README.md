This package makes creating drag and drop UI easier. If you are planning to make an app where you need to drag & drop the matching component, this package would be helpful for you.

## Features

Create drag and drop UI's with few lines of code
Useful for games and other interactive apps

![](./screenshot.gif)

## Methods

DragDropItem
  This is the parent class. It accepts various parameters.

key:
value:
dragChild:
dropChild:
iconData:

Except for key and value , all fields are optional. If no dragChild/dropChild is provided, you'll get a Text widget as your drag/drop components.

DragDropWidget is the base class where you provide reference to your drag drop items. It accepts 3 parameters.
items: Collection of DragDropItem.
onMatched: If the dragged item matched with dropped item.
onMismatched : if the dragged item is not matched with drop items.


## Getting started

Add the packages to pubspec and get started.

drag_drop_match_widget: ^0.0.1

## Usage

```dart

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
```
Use the widget as,

```
DragDropWidget(
              items: items,
              //on  Matched event
              onMatched: (DragDropItem? item) {
                score += 10;
                setState(() {});
                matched.add(item);
                
                if (matched.length == items.length) {
                  print("GAME OVER");
                }
              },
              //on mismatched event
              onMisMatched: (DragDropItem? item) {
                print("Mismatched");
                print(item);
              });

```

## Additional information

To find more information about the package visit https://github.com/sabine33/flutter_drag_drop_match_widget
