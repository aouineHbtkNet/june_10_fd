import 'package:simo_v_7_0_1/modals/items_in_cart_for_admin.dart';

class CartResponse{

  List<CartItemsInfo> listOfCartItemsInfo=[];


  CartResponse();

  factory  CartResponse.fromjson(Map<String,dynamic> json){

    CartResponse cartResponse =CartResponse();
    for( var elemenet in json['listOfOrderProducts']   ){
      CartItemsInfo temp = CartItemsInfo.fromJason(elemenet);
      cartResponse.listOfCartItemsInfo.add(temp);
    }
    return cartResponse ;
  }
}