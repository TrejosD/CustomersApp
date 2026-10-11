import 'package:clientes_app/infrastructure/datasources/appointment_db_datasource.dart';
import 'package:clientes_app/infrastructure/repositories/appointment_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentRepositoryProvider = Provider((ref) =>
    AppointmentRepositoryImpl(
        appointmentDataSource: AppointmentDbDatasource()));
