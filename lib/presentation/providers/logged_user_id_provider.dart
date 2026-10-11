import 'package:clientes_app/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:clientes_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';
import 'package:riverpod/legacy.dart';

final userIdProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return UserNotifier(keyValueStorageService: keyValueStorageService);
});

class UserNotifier extends StateNotifier<UserState> {
  final KeyValueStorageService keyValueStorageService;

  UserNotifier({required this.keyValueStorageService}) : super(UserState()) {
    getUserId();
  }

  Future<void> getUserId() async {
    final userId = await keyValueStorageService.getKeyValue<String>('userId');
    final userName = await keyValueStorageService.getKeyValue<String>(
      'userName',
    );
    final userEmail = await keyValueStorageService.getKeyValue<String>(
      'userEmail',
    );
    state = state.copyWith(
      id: userId,
      name: userName,
      email: userEmail,
      isSaved: true,
    );
  }
}

class UserState {
  final String id;
  final String name;
  final String email;
  final bool isLoading;
  final bool isSaved;

  UserState({
    this.id = '',
    this.email = '',
    this.name = '',
    this.isLoading = false,
    this.isSaved = true,
  });

  UserState copyWith({
    String? id,
    String? name,
    String? email,
    bool? isLoading,
    bool? isSaved,
  }) => UserState(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    isLoading: isLoading ?? this.isLoading,
    isSaved: isSaved ?? this.isSaved,
  );
}
