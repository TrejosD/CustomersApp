import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String fullName, String password);
  Future<User> checkAuthStatus(String token);
}
