import 'package:fpdart/fpdart.dart';
import 'package:seers_assignment/core/error/failure.dart';
import 'package:seers_assignment/features/home/domain/entities/guide_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<GuideEntity>>> getGuides({
    required int limit,
    String? lastGuideId,
  });
}
