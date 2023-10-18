class PinCodeState {
  final String pinCode;
  final PinCodeStatus status;
  final int maxPinCodeLength;
  final int currentErrorInputCount;
  final int maxErrorInputCount;

  PinCodeState({
    this.pinCode = '',
    this.status = PinCodeStatus.initial,
    this.maxPinCodeLength = 4,
    this.currentErrorInputCount = 0,
    this.maxErrorInputCount = 3,
  });

  PinCodeState copyWith({
    String? pinCode,
    PinCodeStatus? status,
    int? maxPinCodeLength,
    int? currentErrorInputCount,
    int? maxErrorInputCount,
  }) {
    return PinCodeState(
      pinCode: pinCode ?? this.pinCode,
      status: status ?? this.status,
      maxPinCodeLength: maxPinCodeLength ?? this.maxPinCodeLength,
      currentErrorInputCount: currentErrorInputCount ?? this.currentErrorInputCount,
      maxErrorInputCount: maxErrorInputCount ?? this.maxErrorInputCount,
    );
  }
}

enum PinCodeStatus {
  initial,
  writing,
  successEnter,
  backToLogin,
  saved,
  mismatch
}