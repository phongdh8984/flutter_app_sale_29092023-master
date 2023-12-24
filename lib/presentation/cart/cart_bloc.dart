import 'dart:async';
import 'package:flutter_app_sale_29092023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_29092023/common/base/base_event.dart';
import 'package:flutter_app_sale_29092023/data/model/cart.dart';
import 'package:flutter_app_sale_29092023/data/model/product.dart';
import 'package:flutter_app_sale_29092023/data/repository/cart_repository.dart';
import 'package:flutter_app_sale_29092023/presentation/cart/cart_event.dart';
import 'package:flutter_app_sale_29092023/util/parser/cart_parser.dart';

class CartBloc extends BaseBloc {
  CartRepository? _cartRepository;
  StreamController<Cart> _cartController = StreamController();
  Stream<Cart> getCartStream() => _cartController.stream;
  StreamController<List<Product>> _listProductController = StreamController();
  Stream<List<Product>> getListProductStream() => _listProductController.stream;

  void setCartRepo(CartRepository repository) {
    _cartRepository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType) {
      case GetCartEvent:
        getCart();
        break;
      // case ConfirmCartEvent:
      //   addToCart(event as AddToCartEvent);
      //   break;
      // case UpdateProductCartEvent:
      //   addToCart(event as AddToCartEvent);
      //   break;
    }
  }

  void getCart() {
    loadingSink.add(true);
    _cartRepository?.getCartService()
        .then((cartDTO) {
      Cart cart = CartParser.parseFromCartDTO(cartDTO);
      List<Product> listProduct = cart.listProduct;
      _cartController.add(cart);
      _listProductController.add(listProduct);

    })
        .catchError((error) { messageSink.add(error); })
        .whenComplete(() => loadingSink.add(false));
  }


  void updateCartProductQuantity(UpdateProductCartEvent event) {
    loadingSink.add(true);
    _cartRepository?.addToCartService(event.idProduct)
        .then((cartDTO) {
      Cart cart = CartParser.parseFromCartDTO(cartDTO);
      _cartController.add(cart);
    })
        .catchError((error) { messageSink.add(error); })
        .whenComplete(() => loadingSink.add(false));
  }

  @override
  void dispose() {
    super.dispose();
    _cartController.close();
  }
}