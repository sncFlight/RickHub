import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_bloc.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_state.dart';
import 'package:rick_hub/modules/pin_code/repositories/pin_code_repository.dart';

class PinCodeScreen extends StatelessWidget {
  final String enteredPin = '';

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {},
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => PinCodeBloc(
          repository: context.read<PinCodeRepository>(),
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: _buildInfoText(),
          ),
          _buildShapes(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 200),
            child: _buildNumPud(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText() {
    return Text(
      'Enter Your Pin',
      style: TextStyle(
        fontSize: 32,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildShapes() {
    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildShape((i < state.pinCode.length) ? Colors.orange : Colors.green),
              ),
          ]
        );
      },
    );
  }

  Widget _buildShape(Color color) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildNumPud() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: i < 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  for (int j = 1; j < 4; j++)
                    numButton(3 * i + j),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(onPressed: null, child: SizedBox()),
                    numButton(0),
                    TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.backspace,
                        color: Colors.black,
                        size: 24,
                      ),
                   ),
                  ],
                ),
            ),
      ],
    );
  }
}
