class LoginState {
  final String username;
  final String password;
  final LoginFormStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = LoginFormStatus.initial,
  });

  LoginState copyWith({
    String? username,
    String? password,
    LoginFormStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

enum LoginFormStatus {
  initial,
  authorized,
  emptyAuthData,
  wrongAuthData,
  error,
  loading,
}