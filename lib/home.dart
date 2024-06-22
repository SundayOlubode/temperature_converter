import 'package:flutter/material.dart';

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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const _ConversionHeader(),
              const SizedBox(height: 20.0),
              const _ConversionInput(),
              const SizedBox(height: 40.0),
              Center(
                child: OutlinedButton(
                  onPressed: () {},
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
              SingleChildScrollView(
                child: Column(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversionInput extends StatelessWidget {
  const _ConversionInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 214, 212, 212),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Text(
              '=',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: TextField(
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 214, 212, 212),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _ConversionHeader extends StatelessWidget {
  const _ConversionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Conversion:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fahrenheit to Celsius',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Celsius to Fahrenheit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }
}
