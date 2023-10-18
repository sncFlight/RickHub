import 'package:rick_hub/modules/auth/login/repositories/auth_repository.dart';

class LocalLoginRepository extends AuthRepository{
  final String defaultUserName = 'user';
  final String defaultPassword = '1234';

  @override
  Future<bool> login({
    required String userName,
    required String password,
  }) async {
    await Future.delayed(Duration(milliseconds: 3000));

    if (
      userName == defaultUserName
      && password == defaultPassword
    ) {
      return true;
    } else {
      return false;
    }
  }

}