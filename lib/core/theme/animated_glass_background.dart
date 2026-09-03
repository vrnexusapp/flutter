import 'package:flutter/material.dart';

import 'dart:math' as math;

class AnimatedGlassBackground extends StatefulWidget {
  final Widget child;

  const AnimatedGlassBackground({super.key, required this.child});

  @override
  State<AnimatedGlassBackground> createState() =>
      _AnimatedGlassBackgroundState();
}

class _AnimatedGlassBackgroundState extends State<AnimatedGlassBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Base pastel background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFF0F5), // Lavender blush
                Color(0xFFFFE4E1), // Misty rose
              ],
            ),
          ),
        ),

        // Animated Orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                // Soft Lavender/Purple Orb
                Positioned(
                  top:
                      size.height * 0.15 +
                      math.sin(_controller.value * 2 * math.pi) * 80,
                  left:
                      size.width * 0.1 +
                      math.cos(_controller.value * 2 * math.pi) * 60,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4C4FB)
                          .withValues(alpha: 0.6), // Soft lavender
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4C4FB).withValues(alpha: 0.6),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                // Soft Peach/Yellow Orb
                Positioned(
                  bottom:
                      size.height * 0.15 +
                      math.cos(_controller.value * 2 * math.pi) * 80,
                  right:
                      size.width * 0.1 +
                      math.sin(_controller.value * 2 * math.pi) * 60,
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFDAB9)
                          .withValues(alpha: 0.6), // Soft peach
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFDAB9).withValues(alpha: 0.6),
                          blurRadius: 120,
                          spreadRadius: 60,
                        ),
                      ],
                    ),
                  ),
                ),
                // Salmon/Pink Orb
                Positioned(
                  top:
                      size.height * 0.4 +
                      math.cos(_controller.value * 2 * math.pi + math.pi) * 100,
                  left:
                      size.width * 0.3 +
                      math.sin(_controller.value * 2 * math.pi + math.pi) * 100,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF9A9E)
                          .withValues(alpha: 0.5), // Salmon pink
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF9A9E).withValues(alpha: 0.5),
                          blurRadius: 150,
                          spreadRadius: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Foreground content (The Scaffolds should have transparent backgrounds)
        widget.child,
      ],
    );
  }
}
