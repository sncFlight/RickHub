import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/constants/palette.dart';
import 'package:rick_hub/constants/text_styles.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_block.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_event.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_state.dart';
import 'package:rick_hub/modules/auth/login/repositories/local_login_repository.dart';
import 'package:rick_hub/constants/route_constants.dart';
import 'package:rick_hub/widgets/logo_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(repository: LocalLoginRepository()),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(c).size.width,
            height: MediaQuery.of(c).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage(
                  ImagePaths.loginBackground,
                ),
                fit: BoxFit.fill,
              )
            ),
            child: Stack(
              children: [

                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    final LoginFormStatus formStatus = state.formStatus;

                    if (formStatus == LoginFormStatus.error) {
                      _showSnackBar(context, 'Ошибка');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 56),
                          child: _buildLogo(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: _buildFieldsInfoText(),
                        ),
                        _usernameField(),
                        _buildPasswordField(),
                        Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: _buildLoginButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildLogo() {
  return Container(
    height: 145,
    child: Stack(
      children: [
        Center(child: Image.asset(ImagePaths.portal, fit: BoxFit.fill)),
        Center(child: LogoWidget()),
      ],
    ),
  );
}

Widget _buildFieldsInfoText() {
  return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Login',
        style: TextStyles.rubik(
          color: Palette.brushGreen,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ));
}

Widget _usernameField() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Login',
          focusedBorder: UnderlineInputBorder (
            borderSide: BorderSide(color: Palette.brushGreen), // Установите цвет здесь
          ),
          hintStyle: TextStyles.rubik(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        onChanged: (value) => context.read<LoginBloc>().add(LoginUsernameChangedEvent(username: value)),
      );
    },
  );
}

Widget _buildPasswordField() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder (
            borderSide: BorderSide(color: Palette.brushGreen), // Установите цвет здесь
          ),
          hintText: 'Password',
          hintStyle: TextStyles.rubik(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChangedEvent(password: value)),
      );
    },
  );
}

Widget _buildLoginButton() {
  return BlocListener<LoginBloc, LoginState>(
    listener: (context, state) {
      final LoginFormStatus formStatus = state.formStatus;
      bool pinCodeOpened = false;

      if (formStatus == LoginFormStatus.authorized && !pinCodeOpened) {
        pinCodeOpened = true;

        Navigator.pushNamed(context, RouteConstants.pinCodeRoute);
      }
    },
    child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return (state.formStatus == LoginFormStatus.loading)
            ? CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Palette.loginButtonColor),
                  minimumSize: MaterialStatePropertyAll(Size(double.infinity, 40)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Установите радиус здесь
                    ),
                  ),
                ),
                onPressed: () => context.read<LoginBloc>().add(LoginSubmittedEvent()),
                child: Text(
                  'Login'.toUpperCase(),
                  style: TextStyles.rubik(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
      },
    ),
  );
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Закрыть',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
