abstract class AuthRepository {
  Future<bool> login({
    required String userName,
    required String password,
  });
}