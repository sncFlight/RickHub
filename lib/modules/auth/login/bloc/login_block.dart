import 'package:bloc/bloc.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_event.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_state.dart';
import 'package:rick_hub/modules/auth/login/repositories/local_login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LocalLoginRepository? repository;

  LoginBloc({
    this.repository,
  }) : super(LoginState()) {
    on<LoginUsernameChangedEvent>(_onLoginUsernameChangedEventCallback);
    on<LoginPasswordChangedEvent>(_onLoginPasswordChangedEventCallback);
    on<LoginSubmittedEvent>(_onLoginSubmittedEventCallback);
  }

  Future<void> _onLoginUsernameChangedEventCallback(LoginUsernameChangedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      username: event.username,
      formStatus: LoginFormStatus.initial
    ));
  }

  Future<void> _onLoginPasswordChangedEventCallback(LoginPasswordChangedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      password: event.password,
      formStatus: LoginFormStatus.initial
    ));
  }

  Future<void> _onLoginSubmittedEventCallback(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    if (
      state.username.isEmpty
      || state.password.isEmpty
    ) {
      emit(state.copyWith(formStatus: LoginFormStatus.emptyAuthData));
    } else {
      try {
        emit(state.copyWith(formStatus: LoginFormStatus.loading));

        final bool? isSuccess = await repository?.login(
          userName: state.username,
          password: state.password,
        );

        if (isSuccess ?? false) {
          emit(state.copyWith(formStatus: LoginFormStatus.authorized));
        } else {
          emit(state.copyWith(formStatus: LoginFormStatus.wrongAuthData));
        }
      } catch (e) {
        emit(state.copyWith(formStatus: LoginFormStatus.error));
      }
    }
  }
}
