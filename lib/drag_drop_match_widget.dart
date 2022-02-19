import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragDropItem {
  //unique key for matching source and target
  //Accepts string
  final String key;
  //Value of a matching target
  //Accepts string
  final String value;
  //Widget to put into draggable
  //Any valid widget, else Text widget is used
  Widget? dragChild;
  //Widget to put into drop field/target
  //Any valid widget, else Text widget is used
  Widget? dropChild;
  //Icon for widget , [Optional]
  IconData? iconData;
  //Feedback widget on dragging, at the pointer
  Widget? feedbackItem;
  //Child to leave at source when dragging
  Widget? childWhenDragging;
  //whether a drop target will accept this model or not
  //[boolean]
  bool willAccept = true;
  //whether the model is accepted or not
  //locked if isAccepted is true, else not
  bool isAccepted;
  //default text style for a drag/drop children
  TextStyle? defaultTextStyle;

  DragDropItem(
      {required this.key,
      required this.value,
      this.iconData,
      this.dragChild,
      this.dropChild,
      this.feedbackItem,
      this.childWhenDragging,
      this.isAccepted = false,
      this.defaultTextStyle}) {
    feedbackItem = Material(
        color: Colors.transparent,
        child: dragChild ?? Icon(iconData, size: 30, color: Colors.teal));
    dragChild = dragChild ??
        Text(key, style: TextStyle(fontSize: 20, color: Colors.red));
    dropChild = dropChild ??
        Text(value,
            style: TextStyle(
              fontSize: 20,
            ));
    childWhenDragging = dragChild ??
        Text(value,
            style: TextStyle(
              fontSize: 20,
            ));
    this.defaultTextStyle = _defaultTextStyle;
  }

  factory DragDropItem.fromMap(MapEntry map) {
    return DragDropItem(
        key: map.key,
        value: map.value,
        dragChild: Text(map.key, style: _defaultTextStyle),
        dropChild: Text(map.value, style: _defaultTextStyle));
  }
}

//dragdrop action , matched or not matched
typedef DragDropAction = void Function(DragDropItem item);
//drag drop default child style
final _defaultTextStyle = TextStyle(fontSize: 50);
final _matchedWidget = Text("✅", style: _defaultTextStyle);

///Drag drop widget for creating match views
///Input your stuffs on [items]
///[onMatched] is handler for matched event
///[onMisMatched] is handler for not matched event
class DragDropWidget extends StatefulWidget {
  //list of items you want to embed in drag drop UI
  final List<DragDropItem> items;
  //on matched event
  final DragDropAction onMatched;
  //on mismatched event
  final DragDropAction onMisMatched;
  DragDropWidget(
      {Key? key,
      required this.items,
      required this.onMatched,
      required this.onMisMatched})
      : super(key: key);

  @override
  State<DragDropWidget> createState() => _DragDropWidgetState();
}

class _DragDropWidgetState extends State<DragDropWidget> {
  //The backdrop style : after drag drop is accepted
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  List<DragDropItem> clonedList() {
    var newList = widget.items.toList();
    newList.shuffle();

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    // dropLists = dropList();

    return Material(
        child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
            children: widget.items.map((DragDropItem item) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Draggable<DragDropItem>(
                data: item,
                childWhenDragging: item.dragChild!,
                feedback: item.feedbackItem!,
                child:
                    item.isAccepted == true ? _matchedWidget : item.dragChild!),
          );
        }).toList()),
        Spacer(),
        Column(
            children: clonedList().map((DragDropItem item) {
          return DragTarget<DragDropItem>(
            onAccept: (receivedItem) {
              if (receivedItem.key == item.key) {
                setState(() {
                  item.isAccepted = true;
                });

                print("ACCEPTED");
                widget.onMatched(receivedItem);
              }
            },
            onLeave: (receivedItem) {
              print("NOT ACCEPTED");
              item.willAccept = false;

              widget.onMisMatched(receivedItem!);
            },
            onWillAccept: (receivedItem) {
              bool willAccept =
                  receivedItem?.key == item.key && !item.isAccepted == true;
              item.willAccept = willAccept;

              return willAccept;
            },
            builder: (context, acceptedItems, rejectedItem) => Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8.0),
                child: Container(
                    color: item.isAccepted ? Colors.green : Colors.transparent,
                    child: item.dropChild)),
          );
        }).toList())
      ],
    ));
  }
}
