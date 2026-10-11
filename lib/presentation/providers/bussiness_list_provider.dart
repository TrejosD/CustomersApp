import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/presentation/providers/bussiness_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bussinessListProvider =
    FutureProvider.family<List<Bussiness>, String>((ref, term) {
  final bussinessDataSource = ref.watch(bussinessRepositoryProvider);
  Future<List<Bussiness>> getAllBussiness() async {
    final bussiness = await bussinessDataSource.getAllBussiness();
    return bussiness;
  }

  Future<List<Bussiness>> getBussinessByTerm() async {
    final bussiness = await bussinessDataSource.getBussinessesByTerm(term);
    return bussiness;
  }

  return (term == "") ? getAllBussiness() : getBussinessByTerm();
});
