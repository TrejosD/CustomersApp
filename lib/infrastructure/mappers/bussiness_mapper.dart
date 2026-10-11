import 'package:clientes_app/domain/entities/bussiness_entity.dart';
import 'package:clientes_app/domain/entities/product.dart';
import 'package:clientes_app/infrastructure/models/bussiness_api/bussiness_response.dart';

class BussinessMapper {
  static Bussiness bussinessDbEntity(BussinessResponse bussResp) => Bussiness(
        name: bussResp.name,
        description: bussResp.description,
        address: bussResp.address,
        linkGPS: bussResp.urlGps,
        positions: bussResp.positions,
        products: bussResp.products
            .map((product) => productDbtoProduct(product))
            .toList(),
        defaultAppointmentTime: bussResp.defaultAppointmentTime,
        schedule: bussResp.schedule,
        infoContacto: bussResp.contactInfo,
        comments: bussResp.customerComments,
        doneService: bussResp.doneServices,
        followers: bussResp.followers,
        starsRate: bussResp.rate,
        id: bussResp.id,
      );

  static Product productDbtoProduct(ProductDB product) => Product(
      id: product.id,
      name: product.name,
      price: product.price,
      time: product.time);
}
