import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seers_assignment/core/constant/app_images.dart';
import 'package:seers_assignment/core/di/init_di.dart';
import 'package:seers_assignment/core/extension/build_context_ext.dart';
import 'package:seers_assignment/core/services/connectivity_service.dart';

class OfflineWrapper extends StatefulWidget {
  final Widget child;

  const OfflineWrapper({super.key, required this.child});

  @override
  State<OfflineWrapper> createState() => _OfflineWrapperState();
}

class _OfflineWrapperState extends State<OfflineWrapper> {
  bool _isConnected = true;
  late StreamSubscription<bool> _subscription;

  @override
  void initState() {
    super.initState();
    final connectivityService = sl<ConnectivityService>();
    _subscription = connectivityService.onConnectivityChanged.listen((
      isConnected,
    ) {
      if (isConnected != _isConnected) {
        setState(() {
          _isConnected = isConnected;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.primary,
      child: Column(
        children: [
          if (!_isConnected)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top,
                bottom: 16,
                left: 20,
                right: 20,
              ),
              color: context.colorScheme.primary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xffDADADA),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppImages.lockIcon,
                      height: 10,
                      width: 10,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          "You're offline.",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Showing what we already have. New things will appear when you're back.",
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (!_isConnected)
            Container(
              height: 4,
              width: double.infinity,
              color: Color(0xffE5E5E5),
            ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
