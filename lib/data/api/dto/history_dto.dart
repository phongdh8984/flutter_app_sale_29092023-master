import 'package:flutter_app_sale_29092023/data/api/dto/product_dto.dart';

class HistoryDTO {
  String? id;
  List<ProductDTO>? listProductDTO;
  String? idUser;
  num? price;
  DateTime? dateCreate;

  HistoryDTO();

  HistoryDTO.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    listProductDTO = ProductDTO.convertJson(json["products"]);
    idUser = json["id_user"];
    price = json["price"];
    dateCreate = json["date_created"];
  }

  static List<HistoryDTO> convertJson(dynamic json) {
    return (json as List).map((e) => HistoryDTO.fromJson(e)).toList();
  }
}