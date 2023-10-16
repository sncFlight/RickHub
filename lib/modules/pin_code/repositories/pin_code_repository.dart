import 'package:rick_hub/enums.dart';

class PinCodeRepository {
  final String pinCode;
  final PinCodeFormStatus formStatus;
  final int pinCodeSize = 4;

  PinCodeRepository({
    this.pinCode = '',
    this.formStatus = PinCodeFormStatus.initial,
  });

}