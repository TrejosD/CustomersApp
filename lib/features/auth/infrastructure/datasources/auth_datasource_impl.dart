import 'package:clientes_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:clientes_app/features/auth/domain/entities/user_entity.dart';
import 'package:clientes_app/features/auth/infrastructure/errors/custom_error.dart';
import 'package:clientes_app/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://appointmentservice-kl4u.onrender.com/citas/auth'));
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/check-auth-status',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(errorMessage: 'Incorrect Token', errorCode: 1);
      }
      throw Exception();
    } catch (e) {
      throw CustomError(
          errorMessage: 'An unexpected error occurred', errorCode: e.hashCode);
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/login', data: {'email': email, 'password': password});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            errorMessage: e.response?.data['message'] ?? 'Wrong Credentials',
            errorCode: e.response!.statusCode!);
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(
            errorMessage: e.response?.data['message'] ?? 'Connection Time-Out',
            errorCode: e.response!.statusCode!);
      }
      throw CustomError(
          errorMessage: 'Something When Wrong',
          errorCode: e.response!.statusCode!);
    } catch (e) {
      throw CustomError(
          errorMessage: 'An unexpected error occurred', errorCode: e.hashCode);
    }
  }

  @override
  Future<User> register(String email, String fullName, String password) async {
    try {
      final response = await dio.post('/register',
          data: {'email': email, 'password': password, "fullName": fullName});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            errorMessage: e.response?.data['message'] ?? 'Wrong Credentials',
            errorCode: e.response!.statusCode!);
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(
            errorMessage: e.response?.data['message'] ?? 'Connection Time-Out',
            errorCode: e.response!.statusCode!);
      }
      throw CustomError(
          errorMessage: 'Something When Wrong',
          errorCode: e.response!.statusCode!);
    } catch (e) {
      throw CustomError(
          errorMessage: 'An unexpected error occurred', errorCode: e.hashCode);
    }
  }
}
