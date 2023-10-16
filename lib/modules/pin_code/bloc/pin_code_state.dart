import 'package:rick_hub/enums.dart';

class PinCodeState {
  final String pinCode;
  final PinCodeFormStatus formStatus;
  
  PinCodeState({
    this.pinCode = '',
    this.formStatus = PinCodeFormStatus.initial,
  });

  PinCodeState copyWith({
    String? pinCode,
    PinCodeFormStatus? formStatus,
  }) {
    return PinCodeState(
      pinCode: pinCode ?? this.pinCode,
      formStatus: formStatus ?? this.formStatus,
    );
  }

}