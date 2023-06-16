import 'package:flutter/material.dart';

/*void main() {
  runApp(const MaterialApp(
      home: InheritedData(
          data: Data(value: 'test'),
          child: Column(
            children: [
              Example(),
              WidgetC(),
            ],
          ))));
}*/
void main() {
  runApp(const MaterialApp(
    home: Example(),
  ));
}

class InheritedData extends InheritedWidget {
  final Data data;
  const InheritedData({
    super.key,
    required this.data,
    required super.child,
  });

  static InheritedData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedData oldWidget) {
    return data.value != oldWidget.data.value; // Include here all dependencies
  }
}

class WidgetWithData extends StatelessWidget {
  final String value;
  const WidgetWithData({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return InheritedData(
      data: Data(value: 'WidgetWithData'),
      child: const WidgetA(),
    );
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({super.key});

  @override
  Widget build(BuildContext context) => const WidgetB();
}

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) => const WidgetC();
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(InheritedData.of(context).data.value);
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  var data = const Data(value: 'bla');

  @override
  Widget build(BuildContext context) {
    return InheritedData(
        data: data,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => setState(() {
                      data = Data(value: 'blub');
                    }),
                child: const Text('Rebuild')),
            SubExample(),
            Text(data.value),
            WidgetA()
          ],
        ));
  }
}

class SubExample extends StatefulWidget {
  const SubExample({super.key});

  @override
  State<SubExample> createState() => _SubExampleState();
}

class _SubExampleState extends State<SubExample> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('The InheritedWidget changed!');
  }

  @override
  Widget build(BuildContext context) {
    final data = InheritedData.of(context).data;
    debugPrint('data: ${data.value}');
    return Container(
        color: Colors.blueAccent,
        child: Row(children: [Text('Helloooo'), Text(data.value)]));
  }
}

class Data {
  final String value;
  const Data({required this.value});
}
