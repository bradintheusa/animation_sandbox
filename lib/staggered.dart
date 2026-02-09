import 'package:flutter/material.dart';

class Staggered extends StatefulWidget {
  const Staggered({Key? key}) : super(key: key);

  @override
  StaggeredState createState() => StaggeredState();
}

class StaggeredState extends State<Staggered> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sendingText;
  late Animation<double> sentText;
  late Animation<double> notifyText;

  static double fadeWeight = 4; // 6 of theses
  final double pausesAmount = 4 * fadeWeight; // 2 of these

  TweenSequenceItem<double> _pause(double weight, double opacity) {
    return TweenSequenceItem(
      tween: ConstantTween<double>(opacity),
      weight: weight,
    );
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    notifyText = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: fadeWeight,
      ),
      _pause(pausesAmount * 2 + (fadeWeight * 4), 0),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: fadeWeight,
      ),
    ]).animate(controller);

    sendingText = TweenSequence<double>([
      _pause(fadeWeight, 0),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: fadeWeight,
      ),
      _pause(pausesAmount, 1),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: fadeWeight,
      ),
      _pause(pausesAmount + (fadeWeight * 4), 0),
    ]).animate(controller);

    sentText = TweenSequence<double>([
      _pause(fadeWeight * 2, 0),
      _pause(pausesAmount, 0),
      _pause(fadeWeight, 0),

      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: fadeWeight,
      ),
      _pause(pausesAmount, 1),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: fadeWeight,
      ),
      _pause(fadeWeight, 0),
    ]).animate(controller);
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

          Container(
            width: 200,
            height: 120,
            color: Colors.white60,
            child: Stack(
              children: [
                // if (notifyText.value != 1)
                Opacity(
                  opacity: notifyText.value,
                  child: const Text("Notify 3 people"),
                ),
                // if (sendingText.value != 1)
                Opacity(
                  opacity: sendingText.value,
                  child: const Text("Sending"),
                ),
                // if (sentText.value != 1)
                Opacity(opacity: sentText.value, child: const Text("Sent")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
