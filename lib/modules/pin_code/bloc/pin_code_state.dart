class PinCodeState {
  final String pinCode;
  final PinCodeStatus status;

  PinCodeState({
    this.pinCode = '',
    this.status = PinCodeStatus.initial,
  });

  PinCodeState copyWith({
    String? pinCode,
    PinCodeStatus? status,
  }) {
    return PinCodeState(
      pinCode: pinCode ?? this.pinCode,
      status: status ?? this.status,
    );
  }
}

enum PinCodeStatus {
  initial,
  writing,
  successEnter,
  saved,
  mismatch
}

// class PinCodeInitialState extends PinCodeState {}
//
// class PinCodeWritingState extends PinCodeState {
//   final int count;
//
//   PinCodeWritingState({
//     required this.count,
//   });
// }
//
// class PinCodeSavedState extends PinCodeState {}
//
// class PinCodeNotSavedState extends PinCodeState {}
//
// class PinCodeMismatchState extends PinCodeState {}