import 'dart:async';
import 'package:flutter_app_sale_29092023/data/api/api_service.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/app_response_dto.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/history_dto.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/product_dto.dart';

class HistoryRepository {
  ApiService? _apiService;

  void setApiService(ApiService apiService) {
    _apiService = apiService;
  }

  Future<List<HistoryDTO>> getListHistoryService() async {
    Completer<List<HistoryDTO>> completer = Completer();
    _apiService
        ?.requestListHistory()
        .then((dataResponse) {
      if (dataResponse.data == null || dataResponse.data == "") {
        completer.complete(List.empty());
      } else {
        var appResponseUserDTO = AppResponseDTO<List<HistoryDTO>>.fromJSON(dataResponse.data, HistoryDTO.convertJson);
        completer.complete(appResponseUserDTO.data);
      }
    })
        .catchError((error) {
      completer.completeError(error.response?.data["message"] ?? error.toString());
    });
    return completer.future;
  }


}
