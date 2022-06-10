import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/modals/category_model.dart';
import 'package:simo_v_7_0_1/modals/product_model.dart';
import 'package:simo_v_7_0_1/modals/product_pgianted_model.dart';
import 'package:simo_v_7_0_1/screens/admin_edit_product.dart';
import 'package:simo_v_7_0_1/screens/admin_selected_product_details.dart';
import 'package:simo_v_7_0_1/screens/admin_show_products_edit_delet.dart';
import 'package:simo_v_7_0_1/screens/selected_product_details.dart';
import 'package:simo_v_7_0_1/widgets_utilities/show_warning_before_delete_widget.dart';

import '../uploadingImagesAndproducts.dart';
import 'multi_used_widgets.dart';

class EditDeleteProductWdgt extends StatefulWidget {
  int index;
  ProductPaginated productPaginated;
  List<ProductPaginated> productList;
  List<Category> categoryList;

  BuildContext context;
  EditDeleteProductWdgt({Key? key ,
    required this.index,
    required this.productPaginated,
    required this.context,
    required this.productList,
    required this.categoryList

  }) : super(key: key);

  @override
  State<EditDeleteProductWdgt> createState() => _EditDeleteProductWdgtState();
}



class _EditDeleteProductWdgtState extends State<EditDeleteProductWdgt> {
  @override
  Widget build(BuildContext context) {

                 ProductPaginated selectedProduct =widget.productPaginated;
    return   Stack(

      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.2,
          child: Card(
            elevation: 20,
            child: Center(
              child: Row(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: (
                        widget.productList[widget.index].foto_producto==null?
                        Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE,
                          fit: BoxFit.fill,)
                            :Image.network(
                          'https://hbtknet.com/storage/notes/${ selectedProduct.foto_producto}',
                          fit: BoxFit.fill,
                        )),
                  ),


                  Container(

                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        selectedProduct.porciento_de_descuento==null ||
                            selectedProduct.porciento_de_descuento! <= 0
                            ?            SizedBox(height: 0,):
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(' ${selectedProduct.porciento_de_descuento?.round()} \% ',
                                style: TextStyle(fontSize: 20,color: Colors.green ,),),
                              Text(' de desct.',style: TextStyle(fontSize: 20,color: Colors.green),),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                '${selectedProduct.nombre_producto}',
                                style: TextStyle(fontSize: 18,color:Colors.black,),),
                            ),
                          ],
                        ),
                        SizedBox(height: 4,),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text('${selectedProduct.precio_ahora}\$',
                              style: TextStyle(
                                fontSize: 24,color:Colors.black,

                              ),
                            ),
                          ),
                        ),








                      ],),
                  ),


                ],
              ),
            ),
          ),
        ),




        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
              onPressed: () {


                Navigator.push(context, MaterialPageRoute(builder:
                (context)=>AdminSelectedProductDetails (productPaginated: selectedProduct,),
                ),);},

              icon: Icon(Icons.more_horiz, size: 28,color: Colors.green,)),
        ),





        Positioned(
          child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AdminEditProduct(selectedproduct:
                  selectedProduct,
                    categoryList: widget.categoryList,
                  ),
                ),
                );
              },
              icon: Container(
                  color: Colors.white,

                  child: Icon(Icons.edit, size: 28,color: Colors.green,))),
        ),



        Positioned(
          bottom: 0,
          child: IconButton(onPressed: () async {

            String message = await ProductUploadingAndDispalyingFunctions().
            deleteProduct(selectedProduct.id??0 );
            Navigator.of(context).pop();
           Navigator.of(context).pushNamed(AdminShowProductsEditDelete.id);
            UsedWidgets().showNotificationDialogue(context, message);

          },
              icon: Icon(Icons.delete, size: 28,color: Colors.red,)),
        ),








      ],



    );

  }
  void showstuff(context, var myString) {
    showDialog(context: context, builder: (context) {return AlertDialog(
      content: myString==''? ClipRect(child: Image.asset(Constants.ASSET_PLACE_HOLDER_IMAGE),) :
      ClipRect(child: Image.network('https://hbtknet.com/storage/notes/$myString'),),
      actions: [ElevatedButton(onPressed: () async {Navigator.of(context).pop();}, child: Center(child: Text('Ok')))],);});}

}

