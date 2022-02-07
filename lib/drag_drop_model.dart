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
