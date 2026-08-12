import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seers_assignment/core/extension/build_context_ext.dart';
import 'package:seers_assignment/features/home/domain/entities/guide_entity.dart';

class GuideCard extends StatelessWidget {
  final GuideEntity guide;

  const GuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: guide.imageUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: guide.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    width: double.infinity,
                    color: context.colorScheme.onSurface,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 48,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : Container(
                  height: 200,
                  width: double.infinity,
                  color: context.colorScheme.outlineVariant,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
        ),
        const SizedBox(height: 14),
        Text(
          guide.title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.3,
            letterSpacing: -0.64,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${guide.subtitle} ${guide.readtime} min.',
          style: context.textTheme.titleSmall?.copyWith(letterSpacing: 0),
        ),
      ],
    );
  }
}
