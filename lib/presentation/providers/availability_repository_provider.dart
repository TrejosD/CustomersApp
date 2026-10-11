import 'package:clientes_app/infrastructure/datasources/availability_db_datasource.dart';
import 'package:clientes_app/infrastructure/repositories/availability_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availabilityRepositoryProvider = Provider((ref) =>
    AvailabilityRepositoryImpl(
        availabilityDataSource: AvailabilityDbDataSource()));
