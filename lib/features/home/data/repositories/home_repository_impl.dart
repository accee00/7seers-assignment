import 'package:fpdart/fpdart.dart';
import 'package:seers_assignment/core/error/failure.dart';
import 'package:seers_assignment/core/services/connectivity_service.dart';
import 'package:seers_assignment/features/home/data/datasources/home_local_datasource.dart';
import 'package:seers_assignment/features/home/data/datasources/home_remote_datasource.dart';
import 'package:seers_assignment/features/home/domain/entities/guide_entity.dart';
import 'package:seers_assignment/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  HomeRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
    required this._connectivityService,
  });

  @override
  Future<Either<Failure, List<GuideEntity>>> getGuides({
    required int limit,
    String? lastGuideId,
  }) async {
    final hasConnection = await _connectivityService.hasConnection;

    if (!hasConnection && lastGuideId == null) {
      try {
        final cachedGuides = await _localDataSource.getCachedGuides();
        if (cachedGuides.isNotEmpty) {
          return right(cachedGuides);
        }
      } catch (_) {}
      return left(const Failure('No internet connection'));
    }

    try {
      final guides = await _remoteDataSource.getGuides(
        limit: limit,
        lastGuideId: lastGuideId,
      );

      if (lastGuideId == null) {
        await _localDataSource.cacheGuides(guides);
      }

      return right(guides);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
