import 'package:flutter/material.dart';

/*void main() {
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
}*/

void main() {
  runApp(const MaterialApp(
      home: WidgetA(
    child: WidgetB(),
  )));
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

class WidgetA extends StatefulWidget {
  final Widget child;
  const WidgetA({super.key, required this.child});

  @override
  State<WidgetA> createState() => _WidgetAState();
}

class _WidgetAState extends State<WidgetA> {
  @override
  Widget build(BuildContext context) {
    debugPrint('WidgetA rebuild');
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => setState(() {}), child: const Text('Press me')),
        widget.child
      ],
    );
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('WidgetB rebuild');
    return Container();
  }
}
