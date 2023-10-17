abstract class PinCodeEvent {}

class PinCodeChangedEvent extends PinCodeEvent {
  final String pinCode;

  PinCodeChangedEvent({
    required this.pinCode,
  });
}

class RouteChangedEvent extends PinCodeEvent {
}