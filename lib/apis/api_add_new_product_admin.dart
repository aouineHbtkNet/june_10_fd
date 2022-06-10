import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
import 'dart:io';
import 'package:http/http.dart' as http;






class AddProductAdminFunction {
   Future  <List<Category>> getProducts( ) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    final Map<String, String> _userprofileHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/bringproductsandcategories');
    http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader);
      var  data = jsonDecode(response.body);
          List<Category> list=[];
     for( var c  in data['categorias']  ){
      Category temp =Category.fromJason(c);
     list.add(temp);
    }

    print('list=========================${list[0].nombre_categoria}');

   //  print('data=========================${data['categorias']}');
    return list ;

  }














  Future<String> uploadANewProductWithoutImage(

  {  required String categoria_id,
    required String nombre_producto,
    required String marca,
    required String contenido,
    required String typo_impuesto,
    required String porciento_impuesto,
    required String valor_impuesto,
    required String precio_ahora,
    required String precio_sin_impuesto,
    required String precio_anterior,
    required String porciento_de_descuento,
    required String valor_descuento,
    required String descripcion,
  }
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    print('Got token');
    final url = Uri.parse(
        Constants.ADD_A_NEW_PRODUCT);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    Map<String, String> body = {
      'categoria_id': categoria_id,
      'nombre_producto': nombre_producto,
      'marca': marca,
      'contenido': contenido,

      'typo_impuesto': typo_impuesto,
      'porciento_impuesto': porciento_impuesto,
      'valor_impuesto': valor_impuesto,
      'precio_ahora': precio_ahora,

      'precio_sin_impuesto': precio_sin_impuesto,
      'precio_anterior': precio_anterior,
      'porciento_de_descuento': porciento_de_descuento,
      'valor_descuento': valor_descuento,

      'descripcion': descripcion
    };
    final response = await post(url, headers: headers, body: jsonEncode(body));

        var json = jsonDecode(response.body);

    return 'New product without an image added';
  }

  Future <String> uploadANewProductWithAnImage(

    File file,
      {
        required String categoria_id,
        required String nombre_producto,
        required String marca,
        required String contenido,
        required String typo_impuesto,
        required String porciento_impuesto,
        required String valor_impuesto,
        required String precio_ahora,
        required String precio_sin_impuesto,
        required String precio_anterior,
        required String porciento_de_descuento,
        required String valor_descuento,
        required String descripcion,
      }


      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    print('Got token');
    final url = Uri.parse(Constants.ADD_A_NEW_PRODUCT);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    Map<String, String> body = {
      'categoria_id': categoria_id,
      'nombre_producto': nombre_producto,
      'marca': marca,
      'contenido': contenido,

      'typo_impuesto': typo_impuesto,
      'porciento_impuesto': porciento_impuesto,
      'valor_impuesto': valor_impuesto,
      'precio_ahora': precio_ahora,

      'precio_sin_impuesto': precio_sin_impuesto,
      'precio_anterior': precio_anterior,
      'porciento_de_descuento': porciento_de_descuento,
      'valor_descuento': valor_descuento,

      'descripcion': descripcion
    };
    var json;
    final response = await post(url, headers: headers, body: jsonEncode(body));
      json = jsonDecode(response.body);
      if (file != null) {await patchImage(file, json['id']);}

    return 'A new product with an  image added';
  }


  Future patchImage(File file, id) async {
    var response;
    // from update
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    var request = http.MultipartRequest('POST',
        Uri.parse('https://hbtknet.com/admin/patchimage/$id'));
    if (file != null) {
      request.files.add(
          await http.MultipartFile.fromPath('foto_producto', file.path));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $spToken',
      });
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);

      var responseJsonDecoded = jsonDecode(response.body);

      print (' response from patch function $responseJsonDecoded');

      return responseJsonDecoded;
    }





  }


}
