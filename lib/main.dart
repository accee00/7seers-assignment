import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seers_assignment/core/theme/app_theme.dart';
import 'package:seers_assignment/features/home/presentation/bloc/home_bloc.dart';
import 'package:seers_assignment/features/home/presentation/screens/main_navigation_screen.dart.dart';
import 'package:seers_assignment/firebase_options.dart';
import 'package:seers_assignment/core/di/init_di.dart';
import 'package:seers_assignment/offline_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDi();
  // await seedGuides(FirebaseFirestore.instance);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeBloc>()..add(GetGuidesEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '7 Seers Assignment',
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          return OfflineWrapper(child: child!);
        },
        home: MainNavScreen(),
      ),
    );
  }
}
