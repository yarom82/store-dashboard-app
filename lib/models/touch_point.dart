import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

@JsonSerializable()
class TouchPoint {
  final String id;
  final String cashier;
  final String type;
  final String state;

  TouchPoint({
    @required this.id,
    this.cashier,
    @required this.type,
    @required this.state
  });

  factory TouchPoint.fromJson(Map<String, dynamic> json) => 
    TouchPoint(id: json["id"], cashier: json["cashierName"], type: 'POS', state: json["cashierName"] != null && json["cashierName"] != '' ? 'online' : 'offline');
}
