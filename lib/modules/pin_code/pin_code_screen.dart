import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/constants/route_constants.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_bloc.dart';
import 'package:rick_hub/modules/pin_code/bloc/pin_code_state.dart';
import 'package:rick_hub/modules/pin_code/repositories/pin_code_repository.dart';
import 'package:rick_hub/widgets/custom_app_bar.dart';

import 'bloc/pin_code_event.dart';

class PinCodeScreen extends StatelessWidget {
  @override
  Widget build(_) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => PinCodeBloc(
          repository: PinCodeRepository(),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShapes(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 10,
                  ),
                  child: _buildNumPud(),
                ),
              ],
            ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 164),
      child: BlocBuilder<PinCodeBloc, PinCodeState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                Padding(
                  padding: EdgeInsets.only(left: (i > 0) ? 16 : 0),
                  child: _buildShape((i < (state.pinCode.length)
                    ? Colors.green
                    : Colors.grey)),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShape(Color color) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNumPud() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BlocListener<PinCodeBloc, PinCodeState>(
        listener: (context, state) {
          if (state.status == PinCodeStatus.successEnter) {
            Navigator.pushNamed(context, RouteConstants.charactersRoute);
          }
        },
        child: BlocBuilder<PinCodeBloc, PinCodeState>(
          builder: (context, state) {
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
                              _buildNumButton(
                                number: ((3 * i) + j),
                                context: context,
                                state: state,
                              ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(onPressed: null, child: SizedBox()),
                            _buildNumButton(
                              number: 0,
                              context: context,
                              state: state,
                            ),
                            TextButton(
                              onPressed: () => context.read<PinCodeBloc>().add(
                                  PinCodeChangedEvent(pinCode: state.pinCode.substring(0, state.pinCode.length - 1))),
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
          },
        ),
      ),
    );
  }

  Widget _buildNumButton({
    required int number,
    required BuildContext context,
    required PinCodeState state,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextButton(
        onPressed: () => context.read<PinCodeBloc>().add(
          PinCodeChangedEvent(pinCode: state.pinCode + number.toString())),
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
