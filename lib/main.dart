import 'package:animation_sandbox/jingle_bell.dart';
import 'package:animation_sandbox/staggered.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AnimateSandbox());
}

class AnimateSandbox extends StatelessWidget {
  const AnimateSandbox({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const AnimateTest(title: 'Flutter Demo Home Page'),
    );
  }
}

class AnimateTest extends StatefulWidget {
  const AnimateTest({super.key, required this.title});

  final String title;

  @override
  State<AnimateTest> createState() => _AnimateTestState();
}

class _AnimateTestState extends State<AnimateTest>
    with TickerProviderStateMixin {
  late AnimationController labelsController;
  late AnimationController bellsController;

  @override
  void initState() {
    super.initState();
    bellsController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
      value: 0,
    );

    // Add a listener to repeat the animation for a continuous jiggle
    bellsController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        bellsController.value = 0;
      }
    });

    labelsController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(
              onPressed: () {
                labelsController.forward(from: 0);
                // bellsController.forward(from: 0);
                bellsController.repeat(count: 6, reverse: true);
              },
              child: const Text('Start Animation'),
            ),

            JingleBell(controller: bellsController),

            Staggered(controller: labelsController),
          ],
        ),
      ),
    );
  }
}
