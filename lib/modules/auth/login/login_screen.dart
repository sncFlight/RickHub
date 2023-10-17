import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_block.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_event.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_state.dart';
import 'package:rick_hub/modules/auth/login/repositories/local_login_repository.dart';
import 'package:rick_hub/constants/route_constants.dart';
import 'package:rick_hub/widgets/logo_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(_) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(repository: LocalLoginRepository()),
        child: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                ImagePaths.loginBackground,
                fit: BoxFit.cover,
              ),

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
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: _usernameField(),
                      ),
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
    );
  }
}

Widget _buildLogo() {
  return Container(
    height: 145,
    child: Stack(
      children: [
        SvgPicture.asset(ImagePaths.portal,
        fit: BoxFit.fill),
        LogoWidget(),
      ],
    ),
  );
}

Widget _buildFieldsInfoText() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text('Login')
  );
}

Widget _usernameField() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
            hintText: 'Username'
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
            hintText: 'Password'
        ),
        onChanged: (value) =>
            context.read<LoginBloc>().add(
                LoginPasswordChangedEvent(password: value)),
      );
    },
  );
}

Widget _buildLoginButton() {
  return BlocListener<LoginBloc, LoginState>(
    listener: (context, state) {
      final LoginFormStatus formStatus = state.formStatus;

      if (formStatus == LoginFormStatus.authorized) {
        Navigator.pushNamed(context, RouteConstants.pinCodeRoute);
      }
    },
    child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return (state.formStatus == LoginFormStatus.loading)
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(LoginSubmittedEvent()),
          child: Text("Логин"),
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
        // Закрываем SnackBar
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  // Показываем SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}