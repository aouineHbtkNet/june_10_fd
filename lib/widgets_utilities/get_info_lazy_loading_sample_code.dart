import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_and_categories_paginated.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/screens/catalogue_widget.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GetdataLazyLoadingScreen extends StatefulWidget {
  const GetdataLazyLoadingScreen({Key? key}) : super(key: key);
  static const String id = '/GetdataLazyLoadingScreen';
  @override
  State<GetdataLazyLoadingScreen> createState() => _GetdataLazyLoadingScreenState();
}

class _GetdataLazyLoadingScreenState extends State<GetdataLazyLoadingScreen> {
  Future  <ProductsAndCategoriesPaginated> getProductsWithCategory({String? category,String? name} ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print ('spToken==================${spToken}');
    final Map<String, String> _userprofileHeader =
    {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $spToken',};
    Uri _tokenUrl = Uri.parse('https://hbtknet.com/client/bringproductos?page=$page');
    Map<String, dynamic> body = {'category':category , 'name': name,};
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
  bool startLogingOut =false;

  initFetchData() async{
    setState(() {onFetchingProcess =true;page=1;totalFromApi=0;productList.clear();categoryList.clear();});
    dataFromApi = await getProductsWithCategory(category: categoryToBeSearched,name:nameToBeSearched);
    setState(() {totalFromApi =dataFromApi.total;productList=dataFromApi.listOfProducts;categoryList=dataFromApi.listOfCategories;page++;
      onFetchingProcess =false;
      hasMore=false;});}

  loadMoreData() async{ if(onFetchingProcess){ return;}//if onFetchingProcess is true stop .don t do anything
    setState(() {onFetchingProcess =true;});//if onFetchingProcess is false  .turn it to tru and go ahead
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
  { super.initState(); initFetchData();
       _scrollController.addListener(() async{
             if(_scrollController.position.pixels ==_scrollController.position.maxScrollExtent) {
                                  if (productList.length  >= totalFromApi  ){setState(() { hasMore=false;});}
                                  //new items added to productList each time loadMoreData() runs .So as long as there is more data ,productList length
                                  // will be less to the total length of the data (totalFromApi).However if productList equals or bigger than the total
                                  //length coming from the api (totalFromApi)  loadMoreData() stops because there is no more,
                                    else{hasMore=true;loadMoreData();}}});
  }
  @override void  dispose(){_scrollController.dispose();super.dispose();}
  @override
  Widget build(BuildContext context) {

    return  startLogingOut==true?Scaffold(body: SpinKitWave(color: Colors.green, size: 50.0,),): Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(children: [IconButton(onPressed: () async {Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.green,),),],),
            Divider(thickness: 2,),

            Column(
              children: [

                buildDropDownSearch(conditionVar:categoryToBeSearched, label:'Filtrar con una categoria',
                    valueParam: categoryToBeSearched,
                    onChanged: (value) {setState(() {categoryToBeSearched=value!;});}, list: categoryList),
                SizedBox(height: 10,),
                Card(elevation: 20, child: TextField(controller: _nameController, onChanged: (value) {nameToBeSearched = value;setState(() {});},
                    decoration: InputDecoration(hintText: 'Buscar un producto',
                      suffixIcon: Padding(padding: const EdgeInsets.all(12.0),
                        child: Container(decoration: BoxDecoration(color: Colors.green,),
                          child: IconButton(onPressed:() async { await initFetchData();},
                            icon: Icon(Icons.search,size: 40,),),),),
                      prefixIcon: nameToBeSearched != '' ?  IconButton(onPressed:(){
                        setState(() {_nameController = TextEditingController(text: '');nameToBeSearched='';});},
                        icon: Icon(Icons.clear),color: Colors.red,iconSize: 24,):SizedBox(height: 0,), // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),),),
              ],
            ),




            Divider(thickness: 6,),

            productList.isEmpty && onFetchingProcess==true  ? SpinKitWave(color: Colors.green, size: 50.0,)
                :productList.isEmpty && onFetchingProcess==false ? Container( decoration:
               BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10.0)),
                child: Padding(padding: const EdgeInsets.all(8.0), child: Text('No hay productos',style: TextStyle(fontSize: 20,color: Colors.white),),))
                :  Expanded(
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
          prefixIcon: conditionVar==null?
          IconButton(icon: Icon(Icons.pages,color: Colors.green,size: 30,), onPressed: () {  },)
              :
          IconButton(icon: Icon(Icons.clear,color: Colors.red,size: 30,),
            onPressed: () {categoryToBeSearched=null;setState(() {});},), hintText: 'Filtrar con categorias',
          label: Text(label ?? '', style: TextStyle(fontSize: 18, color: Colors.blue),),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
         value: valueParam ,
         onChanged: onChanged,
        validator: (value) => value == null ? 'Este campo es obligatorio' : null,
        items: list?.map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
          value: value.id.toString(),
          child: Text(value.nombre_categoria.toString()),)).toList());
  }

}
