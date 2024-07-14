import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Conversion {
  final String type;
  final double value;
  final double convertedValue;
  final String currentOption;
  final String id;

  Conversion({
    Key? key,
    required this.type,
    required this.value,
    required this.convertedValue,
    required this.currentOption,
  }) : id = const Uuid().v4();

  String get text => '$currentOption: $value -> $convertedValue';
}

class ConversionBook extends ValueNotifier<List<Conversion>> {
  ConversionBook._sharedInstance() : super([]);
  static final ConversionBook _shared = ConversionBook._sharedInstance();
  factory ConversionBook() => _shared;

  int get length => value.length;

  void add({required Conversion conversion}) {
    final conversions = value;
    conversions.add(conversion);
    notifyListeners();
  }

  Conversion? conversion({required int atIndex}) {
    return value.length > atIndex ? value[atIndex] : null;
  }
}
