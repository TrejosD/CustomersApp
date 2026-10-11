import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/domain/repositories/bussiness_repository.dart';
import 'package:clientes_app/presentation/providers/bussiness_repository_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/legacy.dart';

final bussinessProvider = StateNotifierProvider.autoDispose
    .family<BussinessNotifier, BussinessState, String>((ref, bussId) {
      final bussinessRepository = ref.watch(bussinessRepositoryProvider);
      return BussinessNotifier(
        bussinessRepository: bussinessRepository,
        bussinessId: bussId,
      );
    });

class BussinessNotifier extends StateNotifier<BussinessState> {
  final BussinessRepository bussinessRepository;
  BussinessNotifier({
    required this.bussinessRepository,
    required String bussinessId,
  }) : super(BussinessState(id: bussinessId)) {
    loadBussiness();
  }

  Future<void> loadBussiness() async {
    try {
      final bussiness = await bussinessRepository.getBussinessByID(state.id);
      state = state.copyWith(isLoading: false, buss: bussiness);
    } on DioException catch (e) {
      throw Exception(
        'Bussiness no se cargo correctamente. Bussiness Notifier $e',
      );
    }
  }
}

class BussinessState {
  final String id;
  final Bussiness? buss;
  final bool isLoading;
  final bool isSaving;

  BussinessState({
    required this.id,
    this.buss,
    this.isLoading = true,
    this.isSaving = false,
  });

  BussinessState copyWith({
    String? id,
    Bussiness? buss,
    bool? isLoading,
    bool? isSaving,
  }) => BussinessState(
    id: id ?? this.id,
    buss: buss ?? this.buss,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
}
