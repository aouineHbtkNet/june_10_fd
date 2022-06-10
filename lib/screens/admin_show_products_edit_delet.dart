
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_and_categories_paginated.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/widgets_utilities/edit_delete_product_wdgt.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'admin_profile_screen.dart';
import 'login_screen.dart';


class AdminShowProductsEditDelete extends StatefulWidget {
  const AdminShowProductsEditDelete({Key? key}) : super(key: key);
  static const String id = '/dispalyProductsToBeEdited';
  @override
  State<AdminShowProductsEditDelete> createState() => _AdminShowProductsEditDeleteState();
}

class _AdminShowProductsEditDeleteState extends State<AdminShowProductsEditDelete> {

  Future  <ProductsAndCategoriesPaginated> getProductsWithCategory({String? category,String? name} ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print ('spToken==================${spToken}');
    final Map<String, String> _userprofileHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/bringproductos?page=$page');
    Map<String, dynamic> body = {'category':category , 'name': name,};
    http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader,body: jsonEncode(body));
    var  data = jsonDecode(response.body);
    print ('data"""""""=========${data['productos']['data']}');
    print ('total""""""=========${data['productos']['total']}');
    ProductsAndCategoriesPaginated productsAndCategoriesPaginated =ProductsAndCategoriesPaginated();
    productsAndCategoriesPaginated= await ProductsAndCategoriesPaginated.fromjson( data );
    return  productsAndCategoriesPaginated;
  }






  void showstuff(context, var myString) {
    showDialog(context: context, builder: (context) {return AlertDialog(
      content: myString == null ? ClipRect(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE),) : ClipRect(child: Image.network('https://hbtknet.com/storage/notes/$myString'),),
      actions: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('Ok')))],);});}



  int page =1;
  ProductsAndCategoriesPaginated dataFromApi=ProductsAndCategoriesPaginated();
  List<ProductPaginated>  productList = [];
  List<Category> categoryList = [];
  String nameToBeSearched ='';
  String?  categoryToBeSearched;
  ScrollController _scrollController =ScrollController();
  bool hasMore=true;
  String? selectedCategory;
  TextEditingController _nameController = TextEditingController(text: '');
  int totalFromApi =0;
  bool isDownloading=false;
  bool isSearching=false;
  bool  filteredList=false;
  bool onFetchingProcess =false;

  initFetchData() async{
    setState(() {
      onFetchingProcess =true;
      page=1;
      totalFromApi=0;
      productList.clear();
      categoryList.clear();
    });
    dataFromApi = await getProductsWithCategory(category: categoryToBeSearched,name:nameToBeSearched);
    setState(() {
      totalFromApi =dataFromApi.total;
      productList=dataFromApi.listOfProducts;
      categoryList=dataFromApi.listOfCategories;
      page++;
      onFetchingProcess =false;
      hasMore=false;});
  }

  loadMoreData() async{
    if(onFetchingProcess){ return;}
    setState(() {
      onFetchingProcess =true;});
    ProductsAndCategoriesPaginated  newData = await getProductsWithCategory(category: categoryToBeSearched,name:nameToBeSearched);
    setState(() {
      productList.addAll(newData.listOfProducts);
      page++;
      onFetchingProcess =false; // just tells when the function in process
    });
  }



  @override
  void initState()
  {
    super.initState();


   initFetchData();
    _scrollController.addListener(() async{
      if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent) {
        if (productList.length  >= totalFromApi  ){
          setState(() { hasMore=false;});
        } else{
          hasMore=true;
          loadMoreData();}}
    });
  }
  @override void  dispose(){_scrollController.dispose();super.dispose();}


  bool startLogingOut =false;

  @override
  Widget build(BuildContext context) {

    return  startLogingOut==true?Scaffold(body: SpinKitWave(color: Colors.green, size: 50.0,),): Scaffold(
      body: SafeArea(
        child: Column(
          children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () async {
              Navigator.of(context).pop();},
                icon: Icon(Icons.arrow_back,color: Colors.green,),
              ),
              IconButton(onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>AdminProfileScreen (),
                ),);},

                icon: Icon(Icons.account_circle_outlined,color: Colors.green,),
              ),
              IconButton(onPressed: () async {
                setState(() {startLogingOut=true;});
                bool answer= await LogoutAdminUserDeliveryMen().logOutAdmin(context);
                print ('answeer    -------         $answer');
                if(answer==true){
                  Navigator.pushNamed(context, LoginScreen.id);
                  UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                } else{
                  UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
                }
                setState(() {startLogingOut=false;});
              }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),
              ),],
          ),


            Divider(thickness: 6,),

            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Editar , Borrar y Ver Productos',
                    style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                )),
            Divider(thickness: 2,color: Colors.blueGrey,),

            Card(
              elevation: 20,
              child: Column(
                children: [
                  buildDropDownSearch(conditionVar:categoryToBeSearched, label:'Filtrar con una categoria',
                      valueParam: categoryToBeSearched,
                      onChanged: (value) {setState(() {categoryToBeSearched=value!;});}, list: categoryList),

                  TextField(controller: _nameController,
                    onChanged: (value) {
                      nameToBeSearched = value;
                      setState(() {

                      });
                    },

                    decoration: InputDecoration(
                      hintText: 'Buscar un producto',
                      //label:Text('Buscar un producto') ,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            // border: Border.all(
                            //
                            //)
                          ),
                          child: IconButton(
                            onPressed:() async {
                             // await initFetchData();
                            },
                            icon: Icon(Icons.search,size: 40,),
                          ),
                        ),
                      ),
                      prefixIcon: nameToBeSearched != '' ?  IconButton(
                        onPressed:(){
                          setState(() {
                            _nameController = TextEditingController(text: '');
                            nameToBeSearched='';});},
                        icon: Icon(Icons.clear),color: Colors.red,iconSize: 24,):SizedBox(height: 0,),

                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),



            Divider(thickness: 6,),

            productList.isEmpty && onFetchingProcess==true  ? SpinKitWave(color: Colors.green, size: 50.0,)
                :productList.isEmpty && onFetchingProcess==false ? Container( decoration:
            BoxDecoration(color: Colors.black,
                borderRadius: BorderRadius.circular(10.0)
            ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('No hay productos',style: TextStyle(fontSize: 20,color: Colors.white),),
                ))

                :  Expanded(
              child: Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: productList.length +1  ,
                      itemBuilder: (BuildContext ctx, index) {
                        if(index < productList.length){  SelectedProductDetails;

                        return EditDeleteProductWdgt( index:index,context:context,
                          productList: productList,
                          categoryList: categoryList,
                          productPaginated: productList[index],
                        );}
                        else{
                          return   hasMore ? SpinKitWave(color: Colors.green, size: 50.0,): SizedBox(height: 0,);}
                      }
                  ),
                ),
              ),
            ) ,



          ],
        ),
      ),
    );
  }


  Widget buildDropDownSearch(
      {
        String ? conditionVar,
        required String? valueParam,
        required String? Function(String? value) onChanged,
        final List? list,
        final String? label


      }) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon:
          conditionVar==null?
          IconButton(icon: Icon(Icons.pages,color: Colors.green,size: 30,),
            onPressed: () {  },)
              :
          IconButton(icon: Icon(Icons.clear,color: Colors.red,size: 30,),
            onPressed: () {
              categoryToBeSearched=null;
              setState(() {});
            },),

          hintText: 'Filtrar con categorias',

          label: Text(
            label ?? '',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),

        value: valueParam ,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Este campo es obligatorio' : null,
        items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
          value: value.id.toString(),
          child: Text(value.nombre_categoria.toString()),)).toList());
  }

}
























// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simo_v_7_0_1/apis/api_add_new_product_admin.dart';
// import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
// import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
// import 'package:simo_v_7_0_1/modals/category_model.dart';
// import 'package:simo_v_7_0_1/modals/json_products_plus_categories.dart';
// import 'package:simo_v_7_0_1/modals/product_and_categories_paginated.dart';
// import 'package:simo_v_7_0_1/modals/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
// import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
// import '../uploadingImagesAndproducts.dart';
// import 'admin_edit_product.dart';
// import 'admin_profile_screen.dart';
// import 'login_screen.dart';
// import 'package:http/http.dart' as http;
//
// void showWarning(context, var data) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Notification'),
//           content: Text('Do you really want to delete this product? '),
//           actions: [
//             ElevatedButton(
//                 onPressed: () async {
//                   String message =
//                       await ProductUploadingAndDispalyingFunctions().deleteProduct(data);
//                   Navigator.of(context).pop();
//                   showMessage(context, message);
//                 },
//                 child: Text('Ok')),
//             ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('cancel'))
//           ],
//         );
//       });
// }
//
// void showMessage(context, String message) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Text(message), actions: [
//             ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok')),
//           ],
//         );});}
//
// class AdminShowProductsEditDelete extends StatefulWidget {
//   static const String id = '/dispalyProductsToBeEdited';
//
//   @override
//   _AdminShowProductsEditDeleteState createState() =>
//       _AdminShowProductsEditDeleteState();
// }
//
// class _AdminShowProductsEditDeleteState  extends State<AdminShowProductsEditDelete> {
//   Widget buildDropDownSearch(
//       {
//         String ? conditionVar,
//         required String? valueParam,
//         required String? Function(String? value) onChanged,
//         final List? list,
//         final String? label
//
//
//       }) {
//     return DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           prefixIcon:
//           conditionVar==null?
//           IconButton(icon: Icon(Icons.pages,color: Colors.green,size: 30,),
//             onPressed: () {  },)
//               :
//           IconButton(icon: Icon(Icons.clear,color: Colors.red,size: 30,),
//             onPressed: () {
//               categoryToBeSearched=null;
//               setState(() {});
//             },),
//
//           hintText: 'Filtrar con categorias',
//
//           label: Text(
//             label ?? '',
//             style: TextStyle(fontSize: 18, color: Colors.blue),
//           ),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//
//         value: valueParam ,
//         onChanged: onChanged,
//         validator: (value) => value == null ? 'Este campo es obligatorio' : null,
//         items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
//           value: value.id.toString(),
//           child: Text(value.nombre_categoria.toString()),)).toList());
//   }
//
//
//
//
//   Widget productAttributes({
//     double? sizeTitle,
//     double? sizedata,
//     Color? colorTitle,
//     Color? colorData,
//     String? fontFamilyTitle,
//     String? fontFamilydata,
//   }) {
//     return Container(
//       margin: EdgeInsets.all(4.0),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('ID', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.id}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               SizedBox(height: 4,),
//               Text('Categoria', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.category}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('Nombre', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.nombre_producto}',
//                 style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('Marca', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.marca}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('Contenido',
//                 style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.contenido}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('Typo de impuesto', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.typo_impuesto}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('porciento de impuesto', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.porciento_impuesto}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('Precio', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.precio_anterior}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('Precio Antes', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.precio_anterior}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//               Text('descripcion', style: TextStyle(fontSize: sizeTitle, color: colorTitle, fontFamily: fontFamilyTitle),),
//               Divider(thickness: 1, color: Colors.blueGrey,),
//               Text('${product?.descripcion}', style: TextStyle(fontSize: sizedata, color: colorData, fontFamily: fontFamilydata),),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Product? product = Product();
//   int page =1;
//   int? idOfSelectedProduct;
//   bool startLogingOut=true;
//   bool done = true;
//   ProductsAndCategories? productsAndCategories;
//   ProductsAndCategoriesPaginated dataFromApi=ProductsAndCategoriesPaginated();
//   List<ProductPaginated>  productList = [];
//   List<Category> categoryList = [];
//   String nameToBeSearched ='';
//   String?  categoryToBeSearched;
//   ScrollController _scrollController =ScrollController();
//   bool hasMore=true;
//   String? selectedCategory;
//   TextEditingController _nameController = TextEditingController(text: '');
//   int totalFromApi =0;
//   bool isDownloading=false;
//   bool isSearching=false;
//   bool  filteredList=false;
//   bool onFetchingProcess =false;
//
//
//
//
//   Future  <ProductsAndCategoriesPaginated> getProductsWithCategory({String? category,String? name} ) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? spToken = await prefs.getString('spToken');
//     print ('spToken==================${spToken}');
//     final Map<String, String> _userprofileHeader = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $spToken',};
//     Uri _tokenUrl = Uri.parse('https://hbtknet.com/admin/bringproductsandcategories?page=$page');
//     Map<String, dynamic> body = {
//       'category':category ,
//       'name': name,};
//     http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader,body: jsonEncode(body));
//     var  data = jsonDecode(response.body);
//     print ('data"""""""=========${data['productos']['data']}');
//     print ('total""""""=========${data['productos']['total']}');
//     // ProductsAndCategories productsAndCategories =ProductsAndCategories();
//     ProductsAndCategoriesPaginated productsAndCategoriesPaginated =ProductsAndCategoriesPaginated();
//
//     productsAndCategoriesPaginated= await ProductsAndCategoriesPaginated.fromjson( data );
//     return  productsAndCategoriesPaginated;
//   }
//
//
//
//
//
//
//
//
//
//   initFetchData() async{
//     setState(() {
//       onFetchingProcess =true;
//       page=1;
//       totalFromApi=0;
//       productList.clear();
//       categoryList.clear();
//     });
//     dataFromApi = await getProductsWithCategory(category: categoryToBeSearched,name:nameToBeSearched);
//     setState(() {
//       totalFromApi =dataFromApi.total;
//       productList=dataFromApi.listOfProducts;
//       categoryList=dataFromApi.listOfCategories;
//       page++;
//
//       onFetchingProcess =false;
//       hasMore=false;
//     });
//
//   }
//
//
//
//   loadMoreData() async{
//
//     if(onFetchingProcess){ return;}
//     setState(() {
//       onFetchingProcess =true;
//     });
//
//     ProductsAndCategoriesPaginated  newData =
//     await getProductsWithCategory(category: categoryToBeSearched,name:nameToBeSearched);
//     setState(() {
//       productList.addAll(newData.listOfProducts);
//       page++;
//       onFetchingProcess =false; // just tells when the function in process
//     });
//   }
//
//
//   @override
//   void initState()
//   {
//     super.initState();
//
//     initFetchData();
//     _scrollController.addListener(() async{
//       if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent) {
//         if (productList.length  >= totalFromApi  ){
//           setState(() { hasMore=false;});
//         } else{
//           hasMore=true;
//           loadMoreData();}}
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     int? productId;
//     return Scaffold(
//         body: SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(onPressed: () async {
//               Navigator.of(context).pop();},
//                 icon: Icon(Icons.arrow_back,color: Colors.green,),
//               ),
//               IconButton(onPressed: () async {
//                 Navigator.push(context, MaterialPageRoute(builder:
//                     (context)=>AdminProfileScreen (),
//                 ),);},
//
//                 icon: Icon(Icons.account_circle_outlined,color: Colors.green,),
//               ),
//               IconButton(onPressed: () async {
//                 setState(() {startLogingOut=true;});
//                 bool answer= await LogoutAdminAndUser().logOutAdmin(context);
//                 print ('answeer    -------         $answer');
//                 if(answer==true){
//                   Navigator.pushNamed(context, LoginScreen.id);
//                   UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
//                 } else{
//                   UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
//                 }
//                 setState(() {startLogingOut=false;});
//               }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),
//               ),],
//           ),
//           Divider(thickness: 6,),
//
//
//
//           Card(
//             elevation: 20,
//             child: Column(
//               children: [
//                 buildDropDownSearch(conditionVar:categoryToBeSearched, label:'Filtrar con una categoria',
//                     valueParam: categoryToBeSearched,
//                     onChanged: (value) {setState(() {categoryToBeSearched=value!;});}, list: categoryList),
//
//                 TextField(controller: _nameController,
//                   onChanged: (value) {
//                     nameToBeSearched = value;
//                     setState(() {
//
//                     });
//                   },
//
//                   decoration: InputDecoration(
//                     hintText: 'Buscar un producto',
//                     //label:Text('Buscar un producto') ,
//                     suffixIcon: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           // border: Border.all(
//                           //
//                           //)
//                         ),
//                         child: IconButton(
//                           onPressed:() async {
//                             await initFetchData();
//                           },
//                           icon: Icon(Icons.search,size: 40,),
//                         ),
//                       ),
//                     ),
//                     prefixIcon: nameToBeSearched != '' ?  IconButton(
//                       onPressed:(){
//                         setState(() {
//                           _nameController = TextEditingController(text: '');
//                           nameToBeSearched='';});},
//                       icon: Icon(Icons.clear),color: Colors.red,iconSize: 24,):SizedBox(height: 0,),
//
//                     // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//
//
//           Divider(thickness: 6,),
//
//
//
//
//
//
//
//
//
//
//
//
//
//           Expanded(
//               child: productsAndCategories == null ? SpinKitWave(color: Colors.green, size: 50.0,):
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView.builder(
//                         itemCount: productsAndCategories?.listOfProducts.length,
//                         itemBuilder: (context, int index) {
//                           product = productsAndCategories?.listOfProducts[index];
//                           productId = productsAndCategories?.listOfProducts[index].id;
//                           return Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Card(
//                               color: Color(0xffF2F7F6),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [Container(width: MediaQuery.of(context).size.width / 3,
//                                             height: MediaQuery.of(context).size.height / 6,
//                                             child: product?.foto_producto != null ? Image.network('https://hbtknet.com/storage/notes/${product?.foto_producto}', fit: BoxFit.fill,)
//                                                 : Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE, fit: BoxFit.fill)),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Container(
//                                             width: MediaQuery.of(context).size.width / 3,
//                                             height: MediaQuery.of(context).size.height / 6,
//                                             child: Column(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//
//
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       Navigator.push(context, MaterialPageRoute(
//                                                           builder: (context) => AdminEditProduct(selectedproduct:
//                                                                 productsAndCategories?.listOfProducts[index],
//                                                             categoryList: productsAndCategories?.listOfCategories,
//                                                           ),
//                                                       ),
//                                                       );
//                                                       },
//                                                     icon: Icon(Icons.edit, size: 20,)),
//
//
//
//                                                 IconButton(onPressed: () async {String message = await ProductUploadingAndDispalyingFunctions().
//                                                           deleteProduct(productsAndCategories?.listOfProducts[index].id ?? 0);
//                                                       Navigator.of(context).pop();
//                                                       Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
//                                                       showMessage(context, message);},
//                                                     icon: Icon(Icons.delete, size: 20,)),],)),],),
//                                     SizedBox(height: 10.0,),
//                                     Container(
//                                       width: double.infinity,
//                                       height: MediaQuery.of(context).size.height / 4,
//                                       decoration: BoxDecoration(
//                                           // border: Border.all(width: 2, color: Colors.blueGrey),
//                                           // borderRadius: BorderRadius.circular(8)
//                                       ),
//                                       child: productAttributes(),
//                                     ),
//
//                                     SizedBox(height: 6,)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//               )
//                   )
//         ],
//       ),
//     ));
//   }
// }
