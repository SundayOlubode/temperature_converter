import 'package:flutter/material.dart';

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
          child: Column(
            children: <Widget>[
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
              const SizedBox(height: 40.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 238, 242, 247),
                  ),
                  child: ListView(),
                ),
              )
            ],
          ),
        ),
      ),
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        const SizedBox(height: 10.0),
        ConversionRadioOptions()
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
