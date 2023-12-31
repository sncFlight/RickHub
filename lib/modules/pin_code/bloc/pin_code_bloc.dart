import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_event.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_state.dart';

class PinCodeBloc extends Bloc<PinCodeEvent, PinCodeState> {
  
  PinCodeBloc() : super(PinCodeState()) {
    on<PinCodeChangedEvent>(_onPinCodeChanged);
    on<RouteChangedEvent>(_onRouteChanged);
  }

  Future<void> _onRouteChanged(RouteChangedEvent event, Emitter<PinCodeState> emit) async {
    emit(state.copyWith(pinCode: '', status: PinCodeStatus.initial));
  }

  Future<void> _onPinCodeChanged(PinCodeChangedEvent event, Emitter<PinCodeState> emit) async {
    bool isSaved = await isPinCodeSaved();

    if (event.pinCode.length < state.maxPinCodeLength) {
      emit(state.copyWith(pinCode: event.pinCode, status: PinCodeStatus.writing));

      return;
    }

    if (isSaved) {
      if (await validatePinCode(event.pinCode)) {
        emit(state.copyWith(pinCode: event.pinCode, status: PinCodeStatus.successEnter));
      } else {
        final int errorInputCount = state.currentErrorInputCount + 1;
        final PinCodeStatus? status;

        if (errorInputCount == state.maxErrorInputCount) {
          status = PinCodeStatus.backToLogin;
          clearPinCode();
        } else {
          status = PinCodeStatus.mismatch;
        }

        emit(state.copyWith(pinCode: '', status: status, currentErrorInputCount: errorInputCount));
      }
    } else {
      await savePinCode(event.pinCode);

      emit(state.copyWith(pinCode: '', status: PinCodeStatus.saved));
    }
  }

  Future<bool> isPinCodeSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('pin_code');
  }

  Future<void> savePinCode(String pinCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pin_code', pinCode);
  }

  Future<void> clearPinCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> validatePinCode(String pinCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedPinCode = prefs.getString('pin_code') ?? '';
    return savedPinCode == pinCode;
  }
}
