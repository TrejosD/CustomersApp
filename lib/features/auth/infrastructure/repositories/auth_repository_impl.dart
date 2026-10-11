import 'package:clientes_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:clientes_app/features/auth/domain/entities/user_entity.dart';
import 'package:clientes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clientes_app/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource dataSource;
  AuthRepositoryImpl([AuthDatasource? dataSource])
      : dataSource = dataSource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String fullName, String password) {
    return dataSource.register(email, fullName, password);
  }
}
