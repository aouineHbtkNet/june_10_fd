import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:simo_v_7_0_1/apis/logout_user_api.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_and_categories_paginated.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/cart_screen.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/screens/user_orders_screen.dart';
import 'package:simo_v_7_0_1/screens/user_profile_screen.dart';
import 'package:simo_v_7_0_1/widgets_utilities/multi_used_widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'catalogue_widget.dart';
import 'login_screen.dart';


class UserCatalogue extends StatefulWidget {
  const UserCatalogue({Key? key}) : super(key: key);
  static const String id = '/ userpage';
  @override
  State<UserCatalogue> createState() => _UserCatalogueState();
}

class _UserCatalogueState extends State<UserCatalogue> {


  Future  <ProductsAndCategoriesPaginated> getProductsWithCategory({String? category,String? name} ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print ('spToken==================${spToken}');
    final Map<String, String> _userprofileHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/client/bringproductos?page=$page');
    Map<String, dynamic> body = {
      'category':category ,
      'name': name,};
    http.Response response = await http.post(_tokenUrl, headers: _userprofileHeader,body: jsonEncode(body));
    var  data = jsonDecode(response.body);

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
      hasMore=false;
      });

  }



  loadMoreData() async{

    if(onFetchingProcess){ return;}
    setState(() {
    onFetchingProcess =true;
     });

    ProductsAndCategoriesPaginated  newData =
    await getProductsWithCategory(category: categoryToBeSearched,name:nameToBeSearched);
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









    return  WillPopScope(
      onWillPop: () async => false,
      child:  startLogingOut==true?Scaffold(body: SpinKitWave(color: Colors.green, size: 50.0,),): Scaffold(
        body: SafeArea(
           child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [



                    IconButton(onPressed: () async {
                      setState(() {startLogingOut=true;});
                      bool answer= await LogoutAdminUserDeliveryMen().logOutUser(context);
                       if(answer==true){
                         Navigator.pushNamed(context, LoginScreen.id);
                         UsedWidgets().showNotificationDialogue(context,'La sesión ha sido cerrada con éxito.');
                       } else{
                         UsedWidgets().showNotificationDialogue(context,'Algo salió mal');
                       }
                       setState(() {startLogingOut=false;});

                    }, icon:  Icon(Icons.exit_to_app,color: Colors.red,),

                    ),

                    IconButton(onPressed: () async {
                      Navigator.of(context).pushNamed(UserOrdersScreen.id);
                    },
                      icon: Icon(Icons.book_outlined,color: Colors.green,),
                    ),
                    IconButton(onPressed: () async {
                      Navigator.of(context).pushNamed(UserProfileScreen.id);
                    },
                      icon: Icon(Icons.account_circle_outlined,color: Colors.green,),
                    ),

                    InkWell(
                      onTap: (){Navigator.of(context).pushNamed(UserCart.id);},
                      child: Padding(
                        padding: const EdgeInsets.only (right: 4.0,left: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all( color: Colors.blueGrey,width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only (right: 4.0,left: 4.0),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_cart_outlined,size: 24,),
                                SizedBox(width: 6,),
                                Text('${context.watch<ShoppingCartProvider>().inCartItemsCount}',
                                  style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
                                ),

                              ],),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(thickness: 6,),

              Card(
                             elevation: 20,
                              child: Column(
                                children: [
                                  buildDropDownSearch(conditionVar:categoryToBeSearched, label:'Filtrar con una categoria',
                                      valueParam: categoryToBeSearched,
                                  onChanged: (value) {setState(() {categoryToBeSearched=value!;});}, list: categoryList),

                                  TextField(controller: _nameController,
                                    onChanged: (value) {nameToBeSearched = value;
                                      setState(() {});}, decoration: InputDecoration(
                                      hintText: 'Buscar un producto',
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(decoration: BoxDecoration(color: Colors.green,),
                                          child: IconButton(
                                            onPressed:() async {await initFetchData();}, icon: Icon(Icons.search,size: 40,),),),),
                                      prefixIcon: nameToBeSearched != '' ?  IconButton(
                                        onPressed:(){
                                          setState(() {_nameController = TextEditingController(text: '');nameToBeSearched='';});},
                                        icon: Icon(Icons.clear),color: Colors.red,iconSize: 24,):SizedBox(height: 0,),),
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
                                    return catalogue( index:index,context:context,product: productList);}
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
