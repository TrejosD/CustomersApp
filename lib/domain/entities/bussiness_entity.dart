// todo esta entidad es necesaria, para ya que necesito mapear la info del JSON y pasar aca

import 'package:clientes_app/domain/entities/product.dart';
import 'package:clientes_app/infrastructure/models/bussiness_api/bussiness_response.dart';

class Bussiness {
  final String id;
  final String name;
  final String description;
  final String address;
  final String linkGPS;
  final List<Position> positions;
  final List<Product> products;
  final int defaultAppointmentTime;
  final Schedule schedule;
  final ContactInfo infoContacto;
  final List<String> comments;
  final int doneService;
  final int followers;
  final double starsRate;
  Bussiness({
    required this.name,
    required this.description,
    required this.address,
    required this.linkGPS,
    required this.positions,
    required this.products,
    required this.defaultAppointmentTime,
    required this.schedule,
    required this.infoContacto,
    required this.comments,
    required this.doneService,
    required this.followers,
    required this.starsRate,
    required this.id,
  });
}
