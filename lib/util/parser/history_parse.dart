import 'package:flutter_app_sale_29092023/data/api/dto/history_dto.dart';
import 'package:flutter_app_sale_29092023/data/model/history.dart';
import 'package:flutter_app_sale_29092023/util/parser/product_parser.dart';

class HistoryParser {
  static History parseFromHistoryDTO(HistoryDTO? HistoryDTO) {
    if (HistoryDTO == null) return History();
    final History history = History();
    history.id = HistoryDTO.id ?? "";
    history.idUser = HistoryDTO.idUser ?? "";
    history.listProduct = HistoryDTO.listProductDTO?.map((e) {
      return ProductParser.parseProductDTO(e);
    }).toList() ?? List.empty();
    history.price = HistoryDTO.price ?? 0;
    history.dateCreate = HistoryDTO.dateCreate ?? DateTime.now();
    return history;
  }
}