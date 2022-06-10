import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simo_v_7_0_1/apis/add_to_sharedPrefereces.dart';
import 'package:simo_v_7_0_1/apis/set_get_sharedPrefrences_functions.dart';
import 'package:simo_v_7_0_1/constant_strings/constant_strings.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/providers/shopping_cart_provider.dart';
import 'package:simo_v_7_0_1/screens/cart_screen.dart';
import 'package:simo_v_7_0_1/screens/login_screen.dart';
import 'package:simo_v_7_0_1/screens/user_orders_screen.dart';
import 'package:simo_v_7_0_1/screens/user_profile_screen.dart';

import 'multi_used_widgets.dart';


class PopUpMenuWidgetUsers extends StatefulWidget {

  bool  putArrow =false;
  bool showcart= false;
  final VoidCallback? callbackArrow;
  final VoidCallback? voidCallbackCart;
  PopUpMenuWidgetUsers({Key? key ,
    required this.putArrow,
     required this.showcart,
    this.callbackArrow,
    this.voidCallbackCart

  }) : super(key: key);

  @override
  State<PopUpMenuWidgetUsers> createState() => _PopUpMenuWidgetUsersState();
}

class _PopUpMenuWidgetUsersState extends State<PopUpMenuWidgetUsers> {




  @override
  Widget build(BuildContext context ) {


    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [

              Visibility(
                  visible: widget.putArrow,
                  child: IconButton(onPressed:widget.callbackArrow, icon: Icon(Icons.arrow_back))),


              Visibility(
                visible: widget.showcart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    UsedWidgets().cartandCounterWidget(context: context,callback: widget.voidCallbackCart),
                    SizedBox(width: 20,),
                    BuildPopUpMenuWidget()
                  ],),
              ),

            ]

        ),
      ),
    );
  }}

class BuildPopUpMenuWidget extends StatefulWidget {
  const BuildPopUpMenuWidget({Key? key}) : super(key: key);

  @override
  State<BuildPopUpMenuWidget> createState() => _BuildPopUpMenuWidgetState();
}

class _BuildPopUpMenuWidgetState extends State<BuildPopUpMenuWidget> {







  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderOne>(context);
    final provider2 = Provider.of<ShoppingCartProvider>(context);

     int screenStatus = context.watch<ShoppingCartProvider>().screenStatus;

    int counterValue = context.watch<ShoppingCartProvider>().getCounterValue;

    return PopupMenuButton(

        color: Colors.black,
        // elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),

        onSelected: (value) async {

          if (value == 1) {



           // provider2.turnOn();

             await provider.getSPToken();
            String? token = provider.spToken;
            await provider.logoutOutUsers(token ??'empty');
            print('Admin with token $token defaulted to empty ');

            await provider.addTokenToSPA('empty');
            await provider.getSPToken();

            String? token2 = provider.spToken;
            print(" Admin Token changed to Empty =======================> $token2");
             print ('turned on ');


          Navigator.pushNamed(context, LoginScreen.id);
           // provider2.turnOff();

          }

          if (value == 2) {
            Navigator.of(context).pushNamed(UserProfileScreen.id);

          }

          if (value == 3) {
            Navigator.of(context).pushNamed(UserOrdersScreen.id);

          }

        },
        icon: Icon(Icons.settings,size: 24,color: Colors.amber,),
        itemBuilder: (context) => [
          PopupMenuItem(child: Text(' Logout', style: TextStyle(color: Colors.white, fontSize: 20.0)), value: 1,),
          PopupMenuItem(child: Text(' profile', style: TextStyle(color: Colors.white, fontSize: 20.0,)), value: 2,),
          PopupMenuItem(child: Text(' Mis ordenes', style: TextStyle(color: Colors.white, fontSize: 20.0,)), value: 3,),


        ]
    );
  }
}

