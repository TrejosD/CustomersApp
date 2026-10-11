import 'package:clientes_app/infrastructure/models/bussiness_api/bussiness_response.dart';

class Positions {
  final String name;
  final List<ProductDB> products;
  Positions({required this.name, required this.products});
}
