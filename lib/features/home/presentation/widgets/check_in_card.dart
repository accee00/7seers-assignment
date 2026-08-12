import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seers_assignment/core/constant/app_images.dart';
import 'package:seers_assignment/core/extension/build_context_ext.dart';

class CheckInCard extends StatelessWidget {
  final bool isFirstTime;

  const CheckInCard({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirstTime)
              Text(
                'Your first check-in.',
                style: context.textTheme.headlineSmall,
              )
            else
              Text.rich(
                TextSpan(
                  text: 'Five ',
                  children: [
                    TextSpan(
                      text: 'quiet',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(text: '  minutes.'),
                  ],
                ),
                style: context.textTheme.headlineSmall,
              ),
            const SizedBox(height: 10),
            Text(
              isFirstTime
                  ? "Five minutes. There's no wrong\nanswer here."
                  : "Your weekly check-in is ready when\nyou are. No pressure to do it now.",
              style: context.textTheme.bodyMedium,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Begin',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onSurface,
                    height: 1.3,
                    letterSpacing: -0.64,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(AppImages.nextArrow),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
