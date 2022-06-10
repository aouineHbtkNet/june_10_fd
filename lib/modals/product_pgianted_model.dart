
import 'category_model.dart';

class ProductPaginated{
  int? id;
  String? foto_producto;
  String? nombre_producto;
  String? marca;
  String? contenido;
  String? typo_impuesto;
  double? porciento_impuesto;
  double? valor_impuesto;
  double? precio_ahora;
  double? precio_sin_impuesto;
  double? precio_anterior;
  double? porciento_de_descuento;
  double? valor_descuento;
  String? descripcion;
  int?  categoria_id;
  String? category;


  ProductPaginated({this.id,this.foto_producto, this.nombre_producto,this.marca,
    this.contenido,this.typo_impuesto,this.porciento_impuesto,this.valor_impuesto,
    this.precio_ahora,this.precio_sin_impuesto,this.precio_anterior,this.porciento_de_descuento, this.valor_descuento,
    this.descripcion,this.categoria_id ,this.category });

  factory ProductPaginated.fromJason(Map<String,dynamic> json){

    return ProductPaginated(
      id: json['id'] ?? null,
      foto_producto: json['foto_producto']  ?? null,
      nombre_producto: json['nombre_producto'] ?? null,
      marca: json['marca'] ?? null,
      contenido: json['contenido'] ?? null,


      typo_impuesto:json['typo_impuesto']  ?? null,


      porciento_impuesto:json['porciento_impuesto'] ==null? null   :double.parse ( json['porciento_impuesto']),

      valor_impuesto:json['valor_impuesto']==null?null :double.parse(json['valor_impuesto']),

      precio_ahora: json['precio_ahora']==null?null:



      double.parse(json['precio_ahora']),
      precio_sin_impuesto: json['precio_sin_impuesto']==null?null:double.parse(json['precio_sin_impuesto']),
      precio_anterior: json['precio_anterior']==null?null:double.parse(json['precio_anterior']),
      porciento_de_descuento: json['porciento_de_descuento']==null?null: double.parse(json['porciento_de_descuento']),
      valor_descuento: json['valor_descuento']==null?null:double.parse(json['valor_descuento']),
      descripcion: json['descripcion'] ?? null,
      categoria_id: json['categoria_id'] ?? null,

      category: json['categoria']?['nombre_categoria']  ?? null,





    );
  }




  Map<String,dynamic> toJson(){

    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data['id']= this.id;
    data['foto_producto']= this.foto_producto;
    data['nombre_producto']= this.nombre_producto;
    data['marca']= this.marca;
    data['contenido']= this.contenido;
    data['typo_impuesto']= this.typo_impuesto;
    data['porciento_impuesto']= this.porciento_impuesto;
    data['valor_impuesto']= this.valor_impuesto;
    data['precio_ahora']= this.precio_ahora;
    data['precio_sin_impuesto']=this.precio_sin_impuesto;
    data['precio_anterior']= this.precio_anterior;
    data['porciento_de_descuento']= this.porciento_de_descuento;
    data['valor_descuento']= this.valor_descuento;
    data['descripcion']=this.descripcion;
    data['categoria_id']= this.categoria_id ;
    data['categoria']?['nombre_categoria']= this.category;

    return data;
  }















// other functions that parse jason


  from1Jason(Map<String,dynamic> json){
    ProductPaginated p = ProductPaginated();
    p.id= json['productos']['id'];
    p.nombre_producto= json['productos']['nombre_producto'];
    //................ you can do that to all fields ex  :  p.foto_nombre= json['productos']['foto_nombre'];
    return p;
  }// in other classes i neeed to use barckets with Course .i need to make an object of the class : Course().from1Json(json);







  static  from2Jason(Map<String,dynamic> json){
    ProductPaginated p = ProductPaginated();
    p.id= json['productos']['id'];
    p.nombre_producto= json['productos']['nombre_producto'];
    //................ you can do that to all fields ex  :  p.foto_nombre= json['productos']['foto_nombre'];
    return p;
  }// in other classes i can do like this: Course.from2Json(json);




  factory   ProductPaginated.from3jason(Map<String,dynamic> json){
    ProductPaginated p = ProductPaginated();
    p.id= json['productos']['id'];
    p.nombre_producto= json['productos']['nombre_producto'];
    //................ you can do that to all fields ex  :  p.foto_nombre= json['productos']['foto_nombre'];
    return p;
  }// in other classes i can do like this: Course.from3Json(json);


}