import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/modals/orders_model_for_admin.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ShoppingCartProvider extends ChangeNotifier{


      var _collectionMap={};
      int get countMap =>_collectionMap.length;
      Map get collectionMap =>_collectionMap;



      void resetCollectionMap(){
        _collectionMap={};
        notifyListeners();

      }





      void increaseQty(ProductPaginated product){
        if(_collectionMap[product]<9){
          _collectionMap[product]+=1;
        }
        notifyListeners();
      }



      int? addproductToMap(ProductPaginated product){
        if (
        _collectionMap.containsKey(product) ){

          if(_collectionMap[product]<9){
            _collectionMap[product] +=1;
          }else{_collectionMap[product] =9; }

        }

        else {

          _collectionMap[product] =1;}

        notifyListeners();

        return _collectionMap[product] ;

      }








      void decreaseProductQty(ProductPaginated product){
        if (_collectionMap.containsKey(product)  &&  _collectionMap[product] >1){
          _collectionMap[product] -=1;

        } else {

          _collectionMap[product] =1;
        }
        notifyListeners();

      }

      void deleteFromMap(ProductPaginated product){

        if (_collectionMap.containsKey(product) ){

          _collectionMap.removeWhere((key, value) => key==product);

        } else {
        }
        notifyListeners();

      }

// precio_ahora
      get productpricesubTotal =>
          _collectionMap.entries.map((product) => product.key.precio_ahora*product.value).toList();
      get productPriceTotal =>
         productpricesubTotal.isEmpty? '0.00': _collectionMap.entries.map((product) => product.key.precio_ahora*product.value).toList().
         reduce((value, element) => value+element).toStringAsFixed(2) ;











// double? precio_sin_impuesto;//==========================2
  get productPrecioSinImpuestoList =>
      _collectionMap.entries.map((product) =>  product.key.precio_sin_impuesto *product.value).toList();
  get productPrecioSinImpuestoTotal=>
      productPrecioSinImpuestoList.isEmpty? '0.00': _collectionMap.entries.map((product) =>
       product.key.precio_sin_impuesto
     *product.value).toList().
      reduce((value, element) => value+element).toStringAsFixed(2) ;


//   double? valor_impuesto;//============================  3
  get productValorImpuestoList =>
      _collectionMap.entries.map((product) => product.key.valor_impuesto *product.value).toList();
  get productValorImpuestoTotal =>
      productValorImpuestoList.isEmpty? '0.00': _collectionMap.entries.map((product) =>  product.key.valor_impuesto*product.value).toList().
      reduce((value, element) => value+element).toStringAsFixed(2) ;

//   double? valor_descuento;//====================4
  get productValorDescuentoList =>
      _collectionMap.entries.map((product) =>product.key.valor_descuento *product.value).toList();
  get productValorDescuentoTotal =>
      productValorDescuentoList.isEmpty? '0.00': _collectionMap.entries.map((product) => product.key.valor_descuento*product.value).toList().
      reduce((value, element) => value+element).toStringAsFixed(2) ;


// incartItems
  get inCartItemsList =>
      _collectionMap.entries.map((product) => product.value).toList();
  get inCartItemsCount=>
      inCartItemsList.isEmpty? '0': _collectionMap.entries.map((product) => product.value).toList().
      reduce((value, element) => value+element).toStringAsFixed(0) ;



// get product list

  get listOfproducts=> _collectionMap.entries.map((product) => product.key).toList();




  int counterX = 10;

  int get getCounterValue => counterX;

  void incrementX() {

    counterX += 1;

    notifyListeners();

  }

  void decrementX() {

    counterX -= 1;

    notifyListeners();

  }










  int  _screenStatus = 0 ;
  int get screenStatus =>_screenStatus;



  void turnOff(){
    _screenStatus= 0;
    notifyListeners();
  }




  void turnOn (){
    _screenStatus = 1;
    notifyListeners();
  }















}