import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';

class ProductsAndCategoriesPaginated{

  List<Category> listOfCategories=[];
  List<ProductPaginated> listOfProducts =[];
  int total=0;

  ProductsAndCategoriesPaginated();


   factory  ProductsAndCategoriesPaginated.fromjson(Map<String,dynamic> json){

    ProductsAndCategoriesPaginated productsAndCategoriesPaginated =ProductsAndCategoriesPaginated();

       productsAndCategoriesPaginated.total = json['productos']['total'];


    for( var c  in json['categorias'] ){
      Category temp =Category.fromJason(c);
      productsAndCategoriesPaginated.listOfCategories.add(temp);
    }

    for( var p  in json['productos']['data']    ){
      ProductPaginated temp =ProductPaginated.fromJason(p);
      productsAndCategoriesPaginated.listOfProducts.add(temp);
    }

    return productsAndCategoriesPaginated;
  }
}