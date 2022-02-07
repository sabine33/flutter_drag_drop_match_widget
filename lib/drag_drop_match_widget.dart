library drag_drop_match_widget;

import 'package:flutter/material.dart';

class DragDropItem {
  final String key;
  final String value;
  Widget? dragChild;
  Widget? dropChild;
  IconData? iconData;
  Widget? feedbackItem;
  Widget? childWhenDragging;
  bool willAccept = true;
  bool isAccepted;
  DragDropItem(
      {required this.key,
      required this.value,
      this.iconData,
      this.dragChild,
      this.dropChild,
      this.feedbackItem,
      this.childWhenDragging,
      this.isAccepted = false}) {
    feedbackItem =
        this.dragChild ?? Icon(iconData, size: 30, color: Colors.teal);
    dragChild = this.dragChild ??
        Text(key,
            style: TextStyle(
              fontSize: 20,
            ));
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
  }

  factory DragDropItem.fromMap(MapEntry map) {
    return DragDropItem(
        key: map.key,
        value: map.value,
        dragChild: Text(map.key),
        dropChild: Text(map.value));
  }
}

typedef DragDropAction = void Function(DragDropItem item);

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
  final acceptedBackdropStyle =
      TextStyle(fontSize: 40, color: Colors.greenAccent);

  //list for another side for matching
  List<DragDropItem> drop_lists = [];
  @override
  void initState() {
    super.initState();

    //create drop targets by shuffling the original list
    drop_lists = List.from(widget.items);
    drop_lists.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
            children: widget.items.map((DragDropItem item) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Draggable<DragDropItem>(
                data: item,
                childWhenDragging: item.dragChild,
                feedback: item.feedbackItem!,
                child: item.isAccepted == true
                    ? Text("✅", style: acceptedBackdropStyle)
                    : item.dragChild!),
          );
        }).toList()),
        Column(
            children: drop_lists.map((DragDropItem item) {
          return DragTarget<DragDropItem>(
            onAccept: (receivedItem) {
              if (receivedItem.key == item.key) {
                setState(() {
                  item.isAccepted = true;
                });

                print("ACCEPTED");

                widget.onMatched(receivedItem);

                // item.dragChild = Text(
                //   "✅",
                //   style: acceptedStyle,
                // );
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
    )));
  }
}
