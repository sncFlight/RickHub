import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/enums.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_event.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_state.dart';
import 'package:rick_hub/modules/pin_code/repositories/pin_code_repository.dart';

class PinCodeBloc extends Bloc<PinCodeEvent, PinCodeState> {
  final PinCodeRepository? repository;

  PinCodeBloc({
    this.repository,
  }) : super(PinCodeState()) {
    on<PinCodeChangedEvent>(_onPinCodeChangedEventCallback);
  }

  Future<void> _onPinCodeChangedEventCallback(PinCodeChangedEvent event, Emitter emit) async {
    final String pinCode = event.pinCode;

    if (pinCode.length == repository?.pinCodeSize) {
      emit(state.copyWith(formStatus: PinCodeFormStatus.authorized));
    } else {
      emit(state.copyWith(formStatus: PinCodeFormStatus.current));
    }

    emit(state.copyWith(pinCode: pinCode));
  }
}