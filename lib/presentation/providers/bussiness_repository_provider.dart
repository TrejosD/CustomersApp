import 'package:clientes_app/infrastructure/datasources/bussiness_db_datasource.dart';
import 'package:clientes_app/infrastructure/repositories/bussiness_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

final bussinessRepositoryProvider = Provider(
  (ref) =>
      BussinessRepositoryImpl(bussinessDataSource: BussinessDBDataSource()),
);
