import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_dashboard/user/domain/entities/user_entity.dart';
import 'package:github_dashboard/user/domain/entities/user_failure.dart';
import 'package:github_dashboard/user/domain/repositories/user_repository_interface.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<GetUserProfile>((event, emit) async {
      emit(UserLoading());
      final result = await userRepository.getUserProfile(event.username);
      result.fold(
        (failure) => emit(UserError(failure: failure)),
        (user) => emit(UserLoaded(user: user)),
      );
    });
  }
}
