import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/modals/user_model.dart';

class CartItemsInfo{
  int order_id =0 ;
  int product_id =0 ;
  int qty =0 ;
  String ?  product_total_price;
  String ?  product_total_base;
  String ?  product_total_taxes;
  String ?   product_total_discount;
  CartItem?  product;


  CartItemsInfo();
  factory  CartItemsInfo.fromJason(Map<String,dynamic> json){
    CartItemsInfo  cartItemsInfo= CartItemsInfo();
    cartItemsInfo.order_id=json['order_id']  ?? cartItemsInfo.order_id;
    cartItemsInfo.product_id=json['product_id']  ??  cartItemsInfo.product_id;
    cartItemsInfo.qty=json['qty']  ??  cartItemsInfo.qty;
    cartItemsInfo.product_total_price=json['product_total_price']  ??  null;
    cartItemsInfo.product_total_base=json['product_total_base'] ??  null ;
    cartItemsInfo.product_total_taxes=json['product_total_taxes']??  null;
    cartItemsInfo.product_total_discount=json['product_total_discount'] ??  null;
    cartItemsInfo.product=CartItem.fromJason(json['product']);

    return  cartItemsInfo;
  }
}



class CartItem{
  String ? foto_producto  ;
  String ? nombre_producto ;
  String ? marca  ;
  String ? contenido  ;
  String ? typo_impuesto ;
  String ?porciento_impuesto ;
  String ? valor_impuesto ;
  String ? precio_ahora ;
  String ? precio_sin_impuesto ;
  String ? precio_anterior ;
  String ? porciento_de_descuento ;
  String ? valor_descuento  ;
  String ? descripcion  ;
  int categoria_id =0 ;
  CartItem();
  factory  CartItem.fromJason(Map<String,dynamic> json){

    CartItem  cartItem= CartItem();
    cartItem.foto_producto=json['foto_producto']  ?? null;
    cartItem.nombre_producto=json['nombre_producto']  ?? null;
    cartItem.marca=json['marca']  ??   null;
    cartItem.contenido=json['contenido']   ?? null;
    cartItem.typo_impuesto=json['typo_impuesto']   ?? null;
    cartItem.porciento_impuesto=json['porciento_impuesto']  ?? null;
    cartItem.precio_ahora=json['precio_ahora']   ?? null;
    cartItem.precio_sin_impuesto=json['precio_sin_impuesto']  ?? null;
    cartItem.precio_anterior=json['precio_anterior']   ?? null;
    cartItem.porciento_de_descuento=json['porciento_de_descuento']  ?? null;
    cartItem.valor_descuento=json['valor_descuento']     ?? null;
    cartItem.descripcion=json['descripcion']    ?? null;
    cartItem.categoria_id=json['categoria_id']    ?? null;
    return  cartItem;
  }
}

