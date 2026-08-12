import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seers_assignment/core/constant/app_images.dart';
import 'package:seers_assignment/features/home/presentation/screens/home_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Scaffold(body: Center(child: Text('Suiii'))),
    const Scaffold(body: Center(child: Text('Suiii'))),
    const Scaffold(body: Center(child: Text('Suiii'))),
    const Scaffold(body: Center(child: Text('Suiii'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(AppImages.homeIcon, 0),
              _buildNavItem(AppImages.dummyIconQ, 1),
              _buildNavItem(AppImages.dummyIcon02, 2),
              _buildNavItem(AppImages.dummyIcon03, 3),
              _buildNavItem(AppImages.dummyIcon04, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 56,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath, height: 24),
            if (_currentIndex == index) ...[
              const SizedBox(height: 6),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xffA8A151),
                  shape: BoxShape.circle,
                ),
              ),
            ] else ...[
              const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }
}
