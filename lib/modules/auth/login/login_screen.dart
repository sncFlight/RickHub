import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/enums.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_block.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_event.dart';
import 'package:rick_hub/modules/auth/login/bloc/login_state.dart';
import 'package:rick_hub/modules/auth/login/repositories/local_login_repository.dart';
import 'package:rick_hub/route/route_constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(_) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
          LoginBloc(
            repository: context.read<LocalLoginRepository>(),
          ),
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final LoginFormStatus formStatus = state.formStatus;

        if (formStatus == LoginFormStatus.error) {
          _showSnackBar(context, 'Ошибка');
        }
      },
      child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usernameField(),
                _passwordField(),
                _loginButton(),
              ],
            ),
          )
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Username'
          ),
          onChanged: (value) => context.read<LoginBloc>().add(LoginUsernameChangedEvent(username: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
              icon: Icon(Icons.security),
              hintText: 'Password'
          ),
          onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChangedEvent(password: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final LoginFormStatus formStatus = state.formStatus;

        if (formStatus == LoginFormStatus.authorized) {
          Navigator.pushNamedAndRemoveUntil(context, RouteConstants.pinCodeRoute, (r) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return (state.formStatus == LoginFormStatus.loading)
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: () => context.read<LoginBloc>().add(LoginSubmittedEvent()),
            child: Text("ВАЙТИ"),
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
}