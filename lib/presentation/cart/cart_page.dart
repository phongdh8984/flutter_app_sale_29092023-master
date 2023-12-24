// import 'package:flutter/material.dart';
// import 'package:flutter_app_sale_29092023/common/app_constant.dart';
// import 'package:flutter_app_sale_29092023/common/base/base_widget.dart';
// import 'package:flutter_app_sale_29092023/common/widget/loading_widget.dart';
// import 'package:flutter_app_sale_29092023/data/api/api_service.dart';
// import 'package:flutter_app_sale_29092023/data/model/cart.dart';
// import 'package:flutter_app_sale_29092023/data/model/product.dart';
// import 'package:flutter_app_sale_29092023/data/repository/cart_repository.dart';
// import 'package:flutter_app_sale_29092023/presentation/cart/cart_bloc.dart';
// import 'package:flutter_app_sale_29092023/presentation/cart/cart_event.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//
//   @override
//   State<CartPage> createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   @override
//   void initState() {
//     super.initState();
//
//   }
//   void clickBackHome() {
//     Navigator.pushNamed(context, "/product");
//   }
//   @override
//   Widget build(BuildContext context) {
//     return PageContainer(
//       providers: [
//         Provider(create: (context) => ApiService()),
//         ProxyProvider<ApiService, CartRepository>(
//           create: (context) => CartRepository(),
//           update: (_, request, repository) {
//             repository ??= CartRepository();
//             repository.setApiService(request);
//             return repository;
//           },
//         ),
//         ProxyProvider<CartRepository, CartBloc>(
//           create: (context) => CartBloc(),
//           update: (_, cartRepo, bloc) {
//             bloc?.setCartRepo(cartRepo);
//             return bloc ?? CartBloc();
//           },
//         )
//       ],
//       child: Container(),
//       appBar: AppBar(
//         title: Text("Giỏ hàng"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () {
//             clickBackHome();
//           },
//         ),
//       ),
//     );
//   }
// }
// class CartContainer extends StatefulWidget {
//   const CartContainer({super.key});
//
//   @override
//   State<CartContainer> createState() => _CartContainerState();
// }
//
// class _CartContainerState extends State<CartContainer> {
//   CartBloc? _bloc;
//   String idCart= "";
//   @override
//   void initState() {
//     super.initState();
//     _bloc = context.read();
//     _bloc?.getCart();
//     idCart = _bloc?.idCart;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SafeArea(
//           child: StreamBuilder<List<Product>>(
//               initialData: const [],
//               stream: _bloc?.getListProductStream(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError || snapshot.data?.isEmpty == true) {
//                   return Container(
//                     child: Center(child: Text("Data empty")),
//                   );
//                 }
//                 return ListView.builder(
//                     itemCount: snapshot.data?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       var itemCart =
//                       var itemProduct = snapshot.data?[index];
//                       return _buildItemFood(,itemProduct, () {
//                         _bloc?.eventSink.add(UpdateProductCartEvent(,itemProduct?.id ?? ""));
//                       });
//                     }
//                 );
//               }
//           ),
//         ),
//         LoadingWidget(bloc: _bloc),
//       ],
//     );
//   }
//   Widget _buildItemFood(String idCart,Product? product, Function()? eventUpdateQuantity) {
//     if (product == null) return Container();
//     return SizedBox(
//       height: 135,
//       child: Card(
//         elevation: 5,
//         shadowColor: Colors.blueGrey,
//         child: Container(
//           padding: const EdgeInsets.only(top: 5, bottom: 5),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Image.network(AppConstant.BASE_URL + product.img,
//                     width: 150, height: 120, fit: BoxFit.fill),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Text(product.name.toString(),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(fontSize: 16)),
//                       ),
//                       Text(
//                           "Giá : ${NumberFormat("#,###", "en_US")
//                               .format(product.price)} đ",
//                           style: const TextStyle(fontSize: 12)),
//                       Row(
//                           children:[
//                             ElevatedButton(
//                               onPressed: eventUpdateQuantity,
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                   MaterialStateProperty.resolveWith((states) {
//                                     if (states.contains(MaterialState.pressed)) {
//                                       return const Color.fromARGB(200, 240, 102, 61);
//                                     } else {
//                                       return const Color.fromARGB(230, 240, 102, 61);
//                                     }
//                                   }),
//                                   shape: MaterialStateProperty.all(
//                                       const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10))))),
//                               child:
//                               const Text("Thêm vào giỏ", style: TextStyle(fontSize: 14)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 5),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                 },
//                                 style: ButtonStyle(
//                                     backgroundColor:
//                                     MaterialStateProperty.resolveWith((states) {
//                                       if (states.contains(MaterialState.pressed)) {
//                                         return const Color.fromARGB(200, 11, 22, 142);
//                                       } else {
//                                         return const Color.fromARGB(230, 11, 22, 142);
//                                       }
//                                     }),
//                                     shape: MaterialStateProperty.all(
//                                         const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10))))),
//                                 child:
//                                 Text("Chi tiết", style: const TextStyle(fontSize: 14)),
//                               ),
//                             ),
//                           ]
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
