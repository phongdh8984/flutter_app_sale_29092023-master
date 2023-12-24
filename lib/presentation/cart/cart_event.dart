import 'package:flutter_app_sale_29092023/common/base/base_event.dart';

class GetCartEvent extends BaseEvent {
  @override
  List<Object?> get props => [];
}

class ConfirmCartEvent extends BaseEvent {
  String idCart;
  String status;
  ConfirmCartEvent(this.idCart,this.status);

  @override
  List<Object?> get props => [];
}

class UpdateProductCartEvent extends BaseEvent {
  String idCart;
  String idProduct;
  int quantity;
  UpdateProductCartEvent(this.idProduct,this.idCart,this.quantity);

  @override
  List<Object?> get props => [];
}