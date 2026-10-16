import 'package:clientes_app/features/auth/domain/entities/user_entity.dart';
import 'package:clientes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:clientes_app/features/auth/infrastructure/errors/custom_error.dart';
import 'package:clientes_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:clientes_app/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:clientes_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/legacy.dart';

enum AuthStatus { authenticated, notAuthenticated, checking }

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      _logOut(e.errorMessage);
    } catch (e) {
      _logOut('Error no controlado');
    }
  }

  Future<void> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final user = await authRepository.register(email, fullName, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      _logOut(e.errorMessage);
    } catch (e) {
      _logOut('Error no controlado');
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getKeyValue<String>('token');
    if (token == null) return _logOut();
    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      _logOut();
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue<String>('token', user.token);
    await keyValueStorageService.setKeyValue<String>('userId', user.id);
    await keyValueStorageService.setKeyValue<String>('userName', user.fullName);
    await keyValueStorageService.setKeyValue<String>('userEmail', user.email);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> _logOut([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    errorMessage: errorMessage ?? this.errorMessage,
    user: user ?? this.user,
  );
}
