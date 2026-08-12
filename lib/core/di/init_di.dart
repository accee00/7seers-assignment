import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seers_assignment/core/services/connectivity_service.dart';
import 'package:seers_assignment/features/home/data/datasources/home_local_datasource.dart';
import 'package:seers_assignment/features/home/data/datasources/home_remote_datasource.dart';
import 'package:seers_assignment/features/home/data/repositories/home_repository_impl.dart';
import 'package:seers_assignment/features/home/domain/repositories/home_repository.dart';
import 'package:seers_assignment/features/home/domain/usecases/get_guides_usecase.dart';
import 'package:seers_assignment/features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initDi() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  _initHome();
}

void _initHome() {
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(firestore: FirebaseFirestore.instance),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(preferences: sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl<HomeRemoteDataSource>(),
      localDataSource: sl<HomeLocalDataSource>(),
      connectivityService: sl<ConnectivityService>(),
    ),
  );

  sl.registerLazySingleton(() => GetGuidesUseCase(sl<HomeRepository>()));
  sl.registerFactory(() => HomeBloc(getGuidesUseCase: sl<GetGuidesUseCase>()));
}
