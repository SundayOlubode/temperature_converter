import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

List<String> conversionOption = ['F to C', 'C to F'];
String currentOption = conversionOption[0];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Converter'),
          backgroundColor: const Color.fromARGB(255, 1, 102, 185),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const ConversionHeader(),
                const SizedBox(height: 20.0),
                // const ConversionInput(),
                const SizedBox(height: 40.0),
                const ConvertButton(),
                const SizedBox(height: 40.0),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 242, 247),
                  ),
                  child: ListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Conversion {
  final String type;
  final double value;
  final double convertedValue;
  final String id;

  Conversion({
    Key? key,
    required this.type,
    required this.value,
    required this.convertedValue,
  }) : id = const Uuid().v4();
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
}

class ConvertButton extends StatefulWidget {
  const ConvertButton({
    super.key,
  });

  @override
  State<ConvertButton> createState() => _ConvertButtonState();
}

class _ConvertButtonState extends State<ConvertButton> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 214, 212, 212),
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                const Text(
                  '=',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
                const SizedBox(
                  width: 150,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 214, 212, 212),
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40.0),
        Center(
          child: OutlinedButton(
            onPressed: () {
              double? parsedValue;
              double? convertedValue;

              try {
                parsedValue = double.parse(_controller.text);

                if (currentOption == 'F to C') {
                  convertedValue = fahrenheitToCelsius(parsedValue);
                  print('converted value $convertedValue');
                } else {
                  convertedValue = celsiusToFahrenheit(parsedValue);
                  print('converted value $convertedValue');
                }

                final conversion = Conversion(
                  type: currentOption,
                  value: parsedValue,
                  convertedValue: convertedValue,
                );

                ConversionBook().add(conversion: conversion);
              } catch (e) {
                print('Error parsing text to int: $e');
              }
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // Rectangular shape without rounded corners
                ),
              ),
              minimumSize: WidgetStateProperty.all<Size>(
                const Size(150, 45),
              ),
            ),
            child: const Text(
              'CONVERT',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  double fahrenheitToCelsius(double fahrenheit) {
    double celsius = (fahrenheit - 32) * 5 / 9;
    return double.parse(celsius.toStringAsFixed(1));
  }

  double celsiusToFahrenheit(double celsius) {
    double fahrenheit = (celsius * 9 / 5) + 32;
    return double.parse(fahrenheit.toStringAsFixed(1));
  }
}

class ConversionHeader extends StatelessWidget {
  const ConversionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Conversion:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        SizedBox(height: 10.0),
        ConversionRadioOptions(),
      ],
    );
  }
}

class ConversionRadioOptions extends StatefulWidget {
  const ConversionRadioOptions({
    super.key,
  });

  @override
  State<ConversionRadioOptions> createState() => _ConversionRadioOptionsState();
}

class _ConversionRadioOptionsState extends State<ConversionRadioOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text(
              'Fahrenheit to Celsius',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Radio(
              value: conversionOption[0],
              groupValue: currentOption,
              onChanged: (value) {
                setState(
                  () {
                    currentOption = value.toString();
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text(
              'Celsius to Fahrenheit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Radio(
              value: conversionOption[1],
              groupValue: currentOption,
              onChanged: (value) {
                setState(
                  () {
                    currentOption = value.toString();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
