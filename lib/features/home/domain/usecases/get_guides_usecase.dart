import 'package:fpdart/fpdart.dart';
import 'package:seers_assignment/core/error/failure.dart';
import 'package:seers_assignment/core/usecase/usecase.dart';
import 'package:seers_assignment/features/home/domain/entities/guide_entity.dart';
import 'package:seers_assignment/features/home/domain/repositories/home_repository.dart';

class GetGuidesParams {
  final int limit;
  final String? lastGuideId;

  const GetGuidesParams({required this.limit, this.lastGuideId});
}

class GetGuidesUseCase implements UseCase<List<GuideEntity>, GetGuidesParams> {
  final HomeRepository repository;

  GetGuidesUseCase(this.repository);

  @override
  Future<Either<Failure, List<GuideEntity>>> call(
    GetGuidesParams params,
  ) async {
    return await repository.getGuides(
      limit: params.limit,
      lastGuideId: params.lastGuideId,
    );
  }
}
