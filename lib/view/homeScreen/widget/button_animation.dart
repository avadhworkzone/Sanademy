import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart'; // Import the glowy_borders package

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController to loop the animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // The duration of one cycle (loop)
    )..repeat(reverse: true); // Loop the animation forward and backward

    // Create an animation that goes from 0.0 to 1.0
    _animation =
        Tween<double>(begin: -1.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Glowy Button Example")),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return AnimatedGradientBorder(
              borderSize: 2.0, // Border width
              glowSize: 8.0, // Glow spread size
              gradientColors: [
                Colors.red.shade400, // First color (Glow effect)
                Colors.amber.shade300
                    .withOpacity(0.5), // Second color (Glow effect)
                Colors.blue.shade500
                    .withOpacity(0.7), // Third color (Glow effect)
              ],
              animationProgress: _animation.value, // Use animated progress
              borderRadius: BorderRadius.circular(15.0),
              child: InkWell(
                onTap: () {
                  // Handle button press action here
                  print("Button Pressed!");
                },
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width: 300.0, // Width of the button
                  height: 50.0, // Height of the button
                  decoration: BoxDecoration(
                    color: Colors.blue, // Background color of the button
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'Press Me', // Button text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
