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
        const Text('Beginning of animation'),
        Animate(
              autoPlay: false,
              value: 1,
              onInit: (controller) {
                controller.value = 1; // Set initial value to 0
                _controller = controller;
              }, // Saves the controller
              child: const Text("I'm animating!"),
            )
            .fade(begin: 0, end: 1.0, duration: 1.ms)
            .then(delay: 500.ms)
            .fade(begin: 1.0, end: 0, duration: 1500.ms)
            .then(delay: 500.ms)
            .fade(begin: 1.0, end: 0, duration: 1500.ms),

        // Animate(
        //       autoPlay: false,
        //       value: 1,
        //       onInit: (controller) =>
        //           _controller = controller, // Saves the controller
        //       child: const Text("Sending"),
        //     )
        //     .then(delay: 1500.ms)

        //     .fadeIn(duration: 1500.ms)
        //     .then(delay: 500.ms)
        //     .fadeOut( duration: 1500.ms)
        //     ,

        // Animate(
        //       autoPlay: false,
        //       value: 1,
        //       onInit: (controller) =>
        //           _controller = controller, // Saves the controller
        //       child: const Text("Sent"),
        //     )
        //     .then(delay: 2500.ms)

        //     .fade(begin: 1.0, end: 0, duration: 1500.ms)
        //     .then(delay: 500.ms)
        //     .fade(begin: 0, end: 1.0, duration: 1500.ms)
        //     ,
        const Text('End of animation'),
        const SizedBox(height: 20),

        // .visibility(maintainState: false)
        // Button
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
