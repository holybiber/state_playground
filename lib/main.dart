import 'package:flutter/material.dart';

// ChangeNotifier is a mixin class and you can either extend or mix it
class CounterState extends ChangeNotifier {
  int _increment = 0;
  int _decrement = 0;
  int get incrementsCount => _increment;
  int get decrementsCount => _decrement;

  void increase() {
    _increment++;
    notifyListeners();
  }

  void decrease() {
    _decrement++;
    notifyListeners();
  }
}

class InheritedCounter extends InheritedWidget {
  final CounterState counterState;
  const InheritedCounter(
      {super.key, required this.counterState, required super.child});

  static InheritedCounter of(BuildContext context) {
    final i = context.dependOnInheritedWidgetOfExactType<InheritedCounter>();
    assert(i != null, "No InheritedCounter found above in the tree.");
    return i!;
  }

  @override
  bool updateShouldNotify(covariant InheritedCounter oldWidget) {
    return counterState != oldWidget.counterState;
  }
}

void main() {
  runApp(MaterialApp(
    home: InheritedCounter(
      counterState: CounterState(),
      child: const CounterApp(),
    ),
  ));
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const AppTitle()), body: const AppBody());
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final state = InheritedCounter.of(context).counterState;
    // Rebuilds its children when CounterState uses notifyListeners()
    return ListenableBuilder(
        listenable: state,
        builder: (context, _) {
          final totalChanges = state.incrementsCount + state.decrementsCount;
          return Text('Counter changes: $totalChanges');
        });
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final state = InheritedCounter.of(context).counterState;

    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // The counter text at the center of the screen
        const BodyText(),

        // Some spacing
        const SizedBox(height: 10),

        // The two tappable buttons
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          // increases the counter and calls notifyListeners()
          ElevatedButton(
              onPressed: state.increase, child: const Text('Increment')),
          const SizedBox(width: 30),
          // decreases the counter and calls notifyListeners()
          ElevatedButton(
              onPressed: state.decrease, child: const Text('Decrement'))
        ])
      ]),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({super.key});

  @override
  Widget build(BuildContext context) {
    final state = InheritedCounter.of(context).counterState;

    return ListenableBuilder(
        listenable: state,
        builder: (context, _) {
          final diff = state.incrementsCount - state.decrementsCount;
          return Text('The count is $diff');
        });
  }
}
