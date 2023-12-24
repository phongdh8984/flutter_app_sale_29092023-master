import 'dart:async';

import 'package:flutter_app_sale_29092023/data/api/api_service.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/app_response_dto.dart';
import 'package:flutter_app_sale_29092023/data/api/dto/cart_dto.dart';

class CartRepository {
  ApiService? _apiService;

  void setApiService(ApiService apiService) {
    _apiService = apiService;
  }
  Future<CartDTO> getCartService() async {
    Completer<CartDTO> completer = Completer();
    _apiService
        ?.requestCart()
        .then((dataResponse) {
      if (dataResponse.data == null || dataResponse.data == "") {
        completer.complete(CartDTO());
      } else {
        var appResponseUserDTO = AppResponseDTO<CartDTO>.fromJSON(dataResponse.data, CartDTO.fromJson);
        completer.complete(appResponseUserDTO.data);
      }
    })
        .catchError((error) {
      completer.completeError(error.response?.data["message"] ?? error.toString());
    });
    return completer.future;
  }
  Future<CartDTO> addToCartService(String idProduct) async {
    Completer<CartDTO> completer = Completer();
    _apiService
        ?.requestAddToCart(idProduct)
        .then((dataResponse) {
          if (dataResponse.data == null || dataResponse.data == "") {
            completer.complete(CartDTO());
          } else {
            var appResponseUserDTO = AppResponseDTO<CartDTO>.fromJSON(dataResponse.data, CartDTO.fromJson);
            completer.complete(appResponseUserDTO.data);
          }
        })
        .catchError((error) {
          completer.completeError(error.response?.data["message"] ?? error.toString());
        });
    return completer.future;
  }

  Future<CartDTO> updateCartProductQuantityService(String idProduct,String idCart, num quantity) async {
    Completer<CartDTO> completer = Completer();
    _apiService
        ?.requestAddToCart(idProduct)
        .then((dataResponse) {
      if (dataResponse.data == null || dataResponse.data == "") {
        completer.complete(CartDTO());
      } else {
        var appResponseUserDTO = AppResponseDTO<CartDTO>.fromJSON(dataResponse.data, CartDTO.fromJson);
        completer.complete(appResponseUserDTO.data);
      }
    })
        .catchError((error) {
      completer.completeError(error.response?.data["message"] ?? error.toString());
    });
    return completer.future;
  }
}