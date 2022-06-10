import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/apis/api_add_new_product_admin.dart';
import 'dart:io';

class AdminFunctions{



  //
  // void calculateProductDynamicvalues ({
  //   double precio_ahora = 0 ,
  //   double 	precio_anterior = 0 ,
  //   double porciento_impuesto=0,
  // }){
  //
  //   double  valor_descuento = 0;
  //   double  porciento_de_descuento=0;
  //   double valor_impuesto=0;
  //   double precio_sin_impuesto=0;
  //
  //
  //
  //   //===============================  The first 2 calculations   Start ===================
  //   //=============   values related to descount and descount percentage       ==================
  //   //=============    variables related : precio_anterior  and precio_ahora      ===============
  //   //porciento_de_descuento
  //   precio_anterior <= 0 || precio_anterior <= precio_ahora ?
  //   porciento_de_descuento= 0:
  //   porciento_de_descuento = ((precio_anterior - precio_ahora) / precio_anterior) * 100;
  //   //valor_descuento
  //   precio_anterior <= 0 || precio_anterior<=precio_ahora ?
  //   valor_descuento =  0 :
  //   valor_descuento = precio_anterior - precio_ahora;
  //
  //   //===============================  The first 2 calculations   End===================
  //
  //
  //   //===============================  The second  2 calculations   Start ===================
  //   //=============   values related to  valor_impuesto and  precio_sin_impuesto  ===============
  //   //=============    variables related :  porciento_impuesto and precio_ahora     ===============
  //   //valor_impuesto
  //   porciento_impuesto <= 0  || precio_ahora<= 0 ?
  //   valor_impuesto = 0:
  //   valor_impuesto = precio_ahora * (porciento_impuesto / 100);
  //
  //   //precio_sin_impuesto
  //
  //   precio_sin_impuesto =  precio_ahora - valor_impuesto;
  //
  // }









  double   valorDescuento ({double precio_ahora = 0 , double 	precio_anterior = 0 , double porciento_impuesto=0,
  }){
    double  valor_descuento = 0;
   return    precio_anterior <= 0 || precio_anterior<=precio_ahora ?
   valor_descuento =  0 :
   valor_descuento = precio_anterior - precio_ahora;
  }

  double   porcientoDescuento ({double precio_ahora = 0 , double 	precio_anterior = 0 , double porciento_impuesto=0,
  }){
    double    porciento_de_descuento = 0;
    return    precio_anterior <= 0 || precio_anterior <= precio_ahora ?
    porciento_de_descuento= 0:
    porciento_de_descuento = ((precio_anterior - precio_ahora) / precio_anterior) * 100;
  }

  double  valorImpuesto  ({double precio_ahora = 0 , double 	precio_anterior = 0 , double porciento_impuesto=0,
  }){
    double valor_impuesto=0;
    return  porciento_impuesto <= 0  || precio_ahora<= 0 ?
    valor_impuesto = 0:
    valor_impuesto = precio_ahora * (porciento_impuesto / 100);
  }

  double  precioSinImpuesto ({double precio_ahora = 0 , double 	precio_anterior = 0 , double porciento_impuesto=0,
  }){
    double valor_impuesto= valorImpuesto( precio_ahora:precio_ahora,precio_anterior: precio_anterior,porciento_impuesto: porciento_impuesto );
    double  precio_sin_impuesto=0;
    return precio_sin_impuesto =  precio_ahora - valor_impuesto;
  }









}