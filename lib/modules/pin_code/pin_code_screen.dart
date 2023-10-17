import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/constants/palette.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_bloc.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_state.dart';
import 'package:rick_hub/modules/pin_code/repositories/pin_code_repository.dart';
import 'package:rick_hub/widgets/custom_app_bar.dart';

class PinCodeScreen extends StatelessWidget {
  final String enteredPin = '';

  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => PinCodeBloc(
          repository: PinCodeRepository(),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildShapes(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 200),
                child: _buildNumPud(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: 'Enter PIN-code',
      widget: SvgPicture.asset(
        ImagePaths.heart,
        width: 24,
        height: 24,
      ),
    );
  }

  Widget _buildShapes() {
    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: _buildShape((i < state.pinCode.length) ? Colors.orange : Colors.green),
            ),
        ]);
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
                    for (int j = 1; j < 4; j++) _buildNumButton(3 * i + j),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(onPressed: null, child: SizedBox()),
                    _buildNumButton(0),
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

  Widget _buildNumButton(int number) {
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
}
