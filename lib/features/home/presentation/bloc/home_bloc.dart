import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:seers_assignment/core/error/failure.dart';
import 'package:seers_assignment/features/home/domain/entities/guide_entity.dart';
import 'package:seers_assignment/features/home/domain/usecases/get_guides_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetGuidesUseCase _getGuidesUseCase;

  HomeBloc({required this._getGuidesUseCase}) : super(HomeInitial()) {
    on<GetGuidesEvent>(_onGetGuides);
    on<LoadMoreGuidesEvent>(_onLoadMoreGuides);
  }

  Future<void> _onGetGuides(
    GetGuidesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final Either<Failure, List<GuideEntity>> result = await _getGuidesUseCase
        .call(const GetGuidesParams(limit: 10));

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (guides) =>
          emit(HomeLoaded(guides: guides, hasReachedMax: guides.length < 10)),
    );
  }

  Future<void> _onLoadMoreGuides(
    LoadMoreGuidesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomeLoaded || currentState.hasReachedMax) return;

    final String lastGuideId = currentState.guides.last.id;

    final Either<Failure, List<GuideEntity>> result = await _getGuidesUseCase
        .call(GetGuidesParams(limit: 10, lastGuideId: lastGuideId));

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (newGuides) => emit(
        HomeLoaded(
          guides: [...currentState.guides, ...newGuides],
          hasReachedMax: newGuides.length < 10,
        ),
      ),
    );
  }
}
