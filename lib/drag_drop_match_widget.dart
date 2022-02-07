library drag_drop_match_widget;

import 'package:flutter/material.dart';

import 'drag_drop_model.dart';

typedef void DragDropAction(DragDropItem item);

///Drag drop widget for creating match views
///Input your stuffs on [items]
///[onMatched] is handler for matched event
///[onMisMatched] is handler for not matched event
class DragDropWidget extends StatefulWidget {
  final List<DragDropItem> items;
  final DragDropAction onMatched;
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
  final acceptedBackdropStyle =
      TextStyle(fontSize: 40, color: Colors.greenAccent);
  List<DragDropItem> drop_lists = [];
  @override
  void initState() {
    super.initState();

    //create drop targets
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
