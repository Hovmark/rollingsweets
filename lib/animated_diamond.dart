import 'package:flutter/material.dart';
import 'package:rollingsweets/main.dart';

class DiamondFadeInGrid extends StatefulWidget {
  const DiamondFadeInGrid({super.key});

  @override
  _DiamondFadeInGridState createState() => _DiamondFadeInGridState();
}

class _DiamondFadeInGridState extends State<DiamondFadeInGrid>
    with TickerProviderStateMixin {
  final double diamondWidth = 100;
  final double diamondHeight = 150;

  List<List<AnimationController>> controllers = [];
  List<List<Animation<double>>> animations = [];
  bool initialized = false;
  bool disposed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final cols = (screenWidth / diamondWidth).ceil();
    final rows = (800 / diamondHeight).ceil();

    for (int y = 0; y < rows; y++) {
      final rowControllers = <AnimationController>[];
      final rowAnimations = <Animation<double>>[];

      for (int x = 0; x < cols; x++) {
        final controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 600),
        );

        final animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        );

        // Staggered start
        Future.delayed(Duration(milliseconds: (x + y) * 250), () {
          if (!disposed && mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!disposed && mounted) controller.forward();
            });
          }
        });

        rowControllers.add(controller);
        rowAnimations.add(animation);
      }

      controllers.add(rowControllers);
      animations.add(rowAnimations);
    }

    initialized = true;
    setState(() {});
  }

  @override
  void dispose() {
    disposed = true;
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 800,
      width: screenWidth,
      child: initialized
          ? TickerMode(
              enabled: mounted && !disposed,
              child: Stack(
                children: [
                  for (int y = 0; y < animations.length; y++)
                    for (int x = 0; x < animations[y].length; x++)
                      AnimatedBuilder(
                        animation: animations[y][x],
                        builder: (context, child) {
                          return Positioned(
                            left: x * diamondWidth,
                            top: y * diamondHeight,
                            child: Opacity(
                              opacity: animations[y][x].value,
                              child: CustomPaint(
                                size: Size(diamondWidth, diamondHeight),
                                painter: DiamondPainter(),
                              ),
                            ),
                          );
                        },
                      ),
                ],
              ),
            )
          : const SizedBox(), // Wait until animations are set
    );
  }
}

class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top
      ..lineTo(size.width, size.height / 2) // Right
      ..lineTo(size.width / 2, size.height) // Bottom
      ..lineTo(0, size.height / 2) // Left
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
