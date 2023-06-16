import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Press the button'), CounterApp()],
          ),
        ),
      ),
    ),
  );
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() {
    return _CounterAppState();
  }
}

class _CounterAppState extends State<CounterApp> {
  var counter = 0;
  var visible = false;

  @override
  Widget build(BuildContext context) {
    final text = visible ? 'Set to invisible' : 'Set to visibled';

    return Column(
      children: [
        Text('Visible = $visible'),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() {
            visible = !visible;
            counter++;
          }),
          child: Text('$counter'),
        ),
      ],
    );
  }
}
