



import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/login_screen.dart';

class LogoutAdminUserDeliveryMen  {




  Future<bool> logOutUser (BuildContext context  ) async {

    final provider =  Provider.of<ProviderOne>(context, listen: false);
    await provider.getSPToken();
    String? token = provider.spToken;
     bool answerfromapi= await provider.logoutOutUsers(token ??'empty');



    print('Admin with token $token defaulted to empty ');


    if(answerfromapi!=true){ }
    else{
      await provider.addUserIdToSPA(0);
      await provider.addUserNameToSPA('');
      await provider.addUserEmailToSPA('');
      await provider.addnUserMobilePhoneToSPA('');
      await provider.addnUserFixedPhoneToSPA('');
      await provider.addnUserAddressToSPA('');
      await provider.addnUserNoDeIdToSPA('');
      await provider.addTokenToSPA('empty');
      await provider.getSPToken();
      String? token2 = provider.spToken;
      print(" Admin Token changed to Empty =======================> $token2");

    }

    // Navigator.pushNamed(context, LoginScreen.id);
    return answerfromapi;
  }




  Future<bool> logOutAdmin (BuildContext context  ) async {

    final provider =  Provider.of<ProviderOne>(context, listen: false);
    await provider.getSPToken();
    String? token = provider.spToken;
    bool answerfromapi= await provider.logoutOutAdmins(token ??'empty');



    print('Admin with token $token defaulted to empty ');


    if(answerfromapi!=true){ }
    else{
      await provider.addUserIdToSPA(0);
      await provider.addUserNameToSPA('');
      await provider.addUserEmailToSPA('');
      await provider.addnUserMobilePhoneToSPA('');
      await provider.addnUserFixedPhoneToSPA('');
      await provider.addnUserAddressToSPA('');
      await provider.addnUserNoDeIdToSPA('');
      await provider.addTokenToSPA('empty');
      await provider.getSPToken();
      String? token2 = provider.spToken;
      print(" Admin Token changed to Empty =======================> $token2");

    }

    // Navigator.pushNamed(context, LoginScreen.id);
    return answerfromapi;
  }


  Future<bool> logOutDeliveryMen (BuildContext context  ) async {

    final provider =  Provider.of<ProviderOne>(context, listen: false);
    await provider.getSPToken();
    String? token = provider.spToken;
    bool answerfromapi= await provider.logoutOutDeliveryMen(token ??'empty');

    print('Delivery man with token $token defaulted to empty ');


    if(answerfromapi!=true){ }
    else{
      await provider.addUserIdToSPA(0);
      await provider.addUserNameToSPA('');
      await provider.addUserEmailToSPA('');
      await provider.addnUserMobilePhoneToSPA('');
      await provider.addnUserFixedPhoneToSPA('');
      await provider.addnUserAddressToSPA('');
      await provider.addnUserNoDeIdToSPA('');
      await provider.addTokenToSPA('empty');
      await provider.getSPToken();
      String? token2 = provider.spToken;
      print(" Admin Token changed to Empty =======================> $token2");

    }

    // Navigator.pushNamed(context, LoginScreen.id);
    return answerfromapi;
  }









}