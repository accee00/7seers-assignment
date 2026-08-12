import 'package:flutter/material.dart';
import 'package:seers_assignment/core/extension/build_context_ext.dart';

class GreetingHeader extends StatelessWidget {
  final bool isFirstTime;

  const GreetingHeader({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    String subtitle;

    if (isFirstTime) {
      greeting = 'Welcome,\nHarsh.';
      subtitle = 'glad you came.';
    } else {
      if (hour < 12) {
        greeting = 'Morning, Harsh.';
        subtitle = "it's a quiet one.";
      } else {
        greeting = 'Evening, Harsh.';
        subtitle = "good work today.";
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting, style: context.textTheme.displayLarge),
        const SizedBox(height: 10),
        Transform.rotate(
          angle: -0.05,
          child: Text(subtitle, style: context.textTheme.titleLarge),
        ),
      ],
    );
  }
}
