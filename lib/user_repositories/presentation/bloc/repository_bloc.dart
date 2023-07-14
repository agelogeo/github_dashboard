import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_entity.dart';
import 'package:github_dashboard/user_repositories/domain/entities/user_repository_failure.dart';
import 'package:github_dashboard/user_repositories/domain/repositories/user_repository_repository_interface.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final IUserRepositoryRepository repositoryRepository;
  RepositoryBloc({
    required this.repositoryRepository,
  }) : super(RepositoryInitial()) {
    on<GetUserRepositories>((event, emit) async {
      emit(RepositoryLoading());
      final result = await repositoryRepository.getUserRepositories(
        event.username,
      );
      result.fold(
        (failure) => emit(RepositoryError(failure: failure)),
        (repositories) => emit(RepositoryLoaded(repositories: repositories)),
      );
    });
  }
}
