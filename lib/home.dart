import 'package:flutter/material.dart';

import 'models/conversion.dart';

List<String> conversionOption = ['F to C', 'C to F'];
String currentOption = conversionOption[0];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Converter')),
          backgroundColor: const Color.fromARGB(255, 2, 83, 33),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ConversionHeader(),
                SizedBox(height: 20.0),
                ConvertButton(),
                SizedBox(height: 20.0),
                HistoryContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 123, 192, 150),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ValueListenableBuilder(
        valueListenable: ConversionBook(),
        builder: (context, conversions, child) {
          return ListView.builder(
            itemCount: conversions.length,
            itemBuilder: (BuildContext context, int index) {
              final reverseIndex = conversions.length - 1 - index;
              final conversion = conversions[reverseIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: ListTile(
                  title: Text(
                    conversion.text,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
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
  late final TextEditingController _inputController;
  late final TextEditingController _outputController;

  @override
  void initState() {
    _inputController = TextEditingController();
    _outputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
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
                    controller: _inputController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 214, 212, 212),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                const Text(
                  '=',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    controller: _outputController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 214, 212, 212),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 2, 83, 33),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
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
                parsedValue = double.parse(_inputController.text);

                if (currentOption == 'F to C') {
                  convertedValue = fahrenheitToCelsius(parsedValue);
                } else {
                  convertedValue = celsiusToFahrenheit(parsedValue);
                }

                _outputController.text = convertedValue.toString();

                final conversion = Conversion(
                  type: currentOption,
                  value: parsedValue,
                  convertedValue: convertedValue,
                  currentOption: currentOption,
                );

                ConversionBook().add(conversion: conversion);
              } catch (e) {
                print('Error parsing text to int: $e');
              }
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              minimumSize: WidgetStateProperty.all<Size>(
                const Size(150, 45),
              ),
            ),
            child: const Text(
              'CONVERT',
              style: TextStyle(
                color: Color.fromARGB(255, 2, 83, 33),
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
              activeColor: const Color.fromARGB(255, 2, 83, 33),
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
              activeColor: const Color.fromARGB(255, 2, 83, 33),
            ),
          ),
        ),
      ],
    );
  }
}
