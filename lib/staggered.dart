import 'package:flutter/material.dart';

class Staggered extends StatefulWidget {
  const Staggered({Key? key}) : super(key: key);

  @override
  StaggeredState createState() => StaggeredState();
}

class StaggeredState extends State<Staggered> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> opacity2;
  late Animation<double> opacity3;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20.0, // 20% of the time spent fading in
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0),
        weight: 60.0, // 60% of the time staying visible
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20.0, // 20% of the time fading out
      ),
    ]).animate(controller);

    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.100, curve: Curves.ease),
      ),
    );

    opacity2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.45, 0.55, curve: Curves.ease),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Column(
        children: [
          ElevatedButton(
            onPressed: () => controller.forward(from: 0),
            child: const Text('Start Animation'),
          ),
          const SizedBox(height: 20),
          Opacity(
            opacity: _opacityAnimation.value,
            child: const Text("Beginning of animation"),
          ),
          const Text("Sending"),
          Opacity(opacity: opacity2.value, child: const Text("Sending")),

          const Text("Sent"),
          // Container(
          //   width: 200,
          //   height: controller.value * 200,
          //   color: Colors.blue,
          // ),
        ],
      ),
    );
  }
}
