abstract class LoginEvent {}

class LoginUsernameChangedEvent extends LoginEvent {
  final String username;

  LoginUsernameChangedEvent({
    required this.username,
  });
}

class LoginPasswordChangedEvent extends LoginEvent {
  final String password;

  LoginPasswordChangedEvent({required this.password});
}

class LoginSubmittedEvent extends LoginEvent {
  LoginSubmittedEvent();
}