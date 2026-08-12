import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seers_assignment/core/constant/app_images.dart';
import 'package:seers_assignment/core/extension/build_context_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seers_assignment/core/di/init_di.dart';
import 'package:seers_assignment/features/home/presentation/bloc/home_bloc.dart';
import 'package:seers_assignment/features/home/presentation/widgets/greeting_header.dart';
import 'package:seers_assignment/features/home/presentation/widgets/check_in_card.dart';
import 'package:seers_assignment/features/home/presentation/widgets/guide_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isFirstTime;
  late final SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = sl<SharedPreferences>();
    _isFirstTime = _prefs.getBool('isFirstTime') ?? true;

    if (_isFirstTime) {
      _prefs.setBool('isFirstTime', false);
    }
  }

  void _resetState() {
    _prefs.setBool('isFirstTime', false);
    setState(() {
      _isFirstTime = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('App State Reset! (Debug mode)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  GreetingHeader(isFirstTime: _isFirstTime),
                  const SizedBox(height: 35),
                  Text(
                    _isFirstTime ? 'START HERE' : 'THIS WEEK',
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  CheckInCard(isFirstTime: _isFirstTime),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is HomeError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          state.message,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }

                  if (state is HomeLoaded) {
                    if (state.guides.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No guides available yet.',
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "THIS WEEK'S GUIDE",
                          style: context.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 12),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.guides.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return GuideCard(guide: state.guides[index]);
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.colorScheme.primary,
      title: GestureDetector(
        onLongPress: _resetState,
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: SvgPicture.asset(AppImages.logo, height: 28),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            width: 50,
            height: 50,
            color: context.colorScheme.onSurface,
            alignment: Alignment.center,
            child: Text('H', style: context.textTheme.titleMedium?.copyWith()),
          ),
        ),
      ],
    );
  }
}
