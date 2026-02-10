import 'package:flutter/material.dart';

class JingleBell extends StatefulWidget {
  final AnimationController controller;
  const JingleBell({Key? key, required this.controller}) : super(key: key);

  @override
  JingleBellState createState() => JingleBellState();
}

class JingleBellState extends State<JingleBell>
    with SingleTickerProviderStateMixin {
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Define the jiggle effect using a Tween and a specific Curve
    // _animation =
    //     Tween<double>(begin: 0, end: 1) // Range of rotation (radians)
    //         .animate(
    //           CurvedAnimation(
    //             parent: widget.controller,
    //             curve: Curves
    //                 .elasticIn, // Use an elastic curve for a bouncy jiggle
    //           ),
    //         );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        shape: BoxShape.circle,
      ),

      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: widget.controller.isAnimating
                ? widget.controller.value - 0.5
                : 0,
            child: Icon(
              widget.controller.isAnimating
                  ? Icons.notifications_active
                  : Icons.notifications,
              size: 50.0,
              color: Colors.amber,
            ),
          );
        },
      ),
    );
  }
}
