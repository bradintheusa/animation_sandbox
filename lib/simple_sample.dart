import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SimpleSample extends StatefulWidget {
  const SimpleSample({super.key});

  @override
  State<SimpleSample> createState() => _SimpleSampleState();
}

class _SimpleSampleState extends State<SimpleSample> {
  // 1. Create a variable to hold the controller
  AnimationController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 2. The Animated Widget
        Animate(
          autoPlay: false, // Prevents immediate start
          onInit: (controller) =>
              _controller = controller, // Saves the controller
          child: const Text("I'm animating!"),
        ).fadeIn(duration: 500.ms).slideY(begin: 1, end: 0),

        const SizedBox(height: 20),

        // 3. The Button
        ElevatedButton(
          onPressed: () {
            // 4. Use the controller to play the animation
            _controller?.forward(from: 0);
          },
          child: const Text("Start Animation"),
        ),
      ],
    );
  }
}
