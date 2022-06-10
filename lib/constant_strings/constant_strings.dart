class Constants {

//strings
  static const String LOGO_IMAGE ='assets/hbtkLogo.png';
  static const String ASSET_PLACE_HOLDER_IMAGE ='assets/imagePlaceHolder.png';
  static const List<String> LIST_MANERA_DE_ENTREGA =['Al domicilio', 'A la tienda'];
  static const List<String> LIST_MANERA_DE_PAGO =['A la linea', 'DataFono','efectivo'];
  static const String USER_TABLE_KEY ='table';
  static const String USER_TOKEN_KEY ='spToken';
  static const String USER_ID_KEY ='id';
  static const String USER_NAME_KEY ='username';
  static const String USER_EMAIL_KEY ='email';
  static const String USER_MOBILE_PHONE_KEY ='userMobilePhone';
  static const String USER_FIXED_PHONE_KEY ='userFixedName';
  static const String USER_ADDRESS_KEY ='userAddress';
  static const String USER_IDENTIFICATION_NUMBER_KEY ='useridentificationNumber';
  static const String IMAGE_FROM_STORAGE_API ='https://hbtknet.com/storage/notes/';
  static const String ALL_LOGIN_T0_FILTER= 'https://hbtknet.com/publicapi/checktypeendponit';


//urls admins



  static const String ADD_NEW_ADMIN ='https://hbtknet.com/admin/admin/register';
  static const String ADD_NEW_DELIVERY_MAN ='https://hbtknet.com/admin/deleviry/registerDeliveryman';
  static const String GET_ALL_CATEGORIES ='https://hbtknet.com/admin/getallcategories';
  static const String DELETE_CATEGORY ='https://hbtknet.com/admin/deleteacategory';
  static const String ADMIN_EDIT_INFO ='https://hbtknet.com/admin/editadmininfo';


  static const String DELIVERY_MEN_CHANGE_PSSWRD_BY_ADMIN ='https://hbtknet.com/admin/changeDeliveryMenpassword';
  static const String DELIVERY_MEN_CHANGE_PSSWRD ='https://hbtknet.com/repartidor/changeDeliveryMenpassword';


  static const String DELIVERY_MEN_EDIT_INFO_BY_ADMIN ='https://hbtknet.com/admin/updateDeliveryMenInfo';

  static const String DELIVERY_MEN_EDIT_INFO ='https://hbtknet.com/repartidor/updateDeliveryMenInfo';
  static const String ADMIN_CHANGE_PASSWORD ='https://hbtknet.com/admin/changeadminpassword';
  static const String LOGIN_ADMIN ='https://hbtknet.com/publicapi/admin/login';
  static const String LOGOUT_ADMIN =  'https://hbtknet.com/admin/logout/admin';
  static const String LOGOUT_DELIVERY_MAN = 'https://hbtknet.com/repartidor/logout/deliveryman';
  static const String ADD_NEW_PRODUCT = 'https://hbtknet.com/admin/addnewproduct';
  static const String ADD_A_NEW_PRODUCT ='https://hbtknet.com/admin/subirAProductostest';
  static const String ADD_IMAGE ='https://hbtknet.com/admin/subirAProductostest';
  static const String GET_ORDERS_FOR_Admins='https://hbtknet.com/admin/getallordersadmin';
  static const String GET_ORDERS_WITH_DETAILS_FOR_Admins='https://hbtknet.com/admin/getAllOrdersWithProductdetails';
  static const String GET_ORDERS_WITH_DETAILS_FOR_Admins_N0_FILTER='https://hbtknet.com/admin/getAllOrdersWithProductdetailsNoFilter';
  static const String DELETE_ORDER='https://hbtknet.com/admin/deleteOrder';



  //urls users

  static const String REGISTER_USER = 'https://hbtknet.com/publicapi/user/register';
  static const String LOGIN_USER =  'https://hbtknet.com/publicapi/user/login';
  static const String LOGOUT_USER = 'https://hbtknet.com/client/user/logout';
  static const String USER_EDIT_INFO ='https://hbtknet.com/client/user/edituserinfo';
  static const String USER_EDIT_PSWRD_UN ='https://hbtknet.com/client/user/edituserPaswdUnm';
  static const String REQUEST_CODE_FOR_USER = 'https://hbtknet.com/publicapi/user/recoverPassowrd';
  static const String SEND_CODE_AND_NEW_PASSWORD_USER = 'https://hbtknet.com/publicapi/user/sendRecoverycode';
  static const String GET_PRODUCT_USER = 'https://hbtknet.com/client/getproductsurl';
  static const String GET_ORDERS_FOR_USER ='https://hbtknet.com/client/get_user_orders';
  static const String UPDATE_STATUS ='https://hbtknet.com/client/get_status-updated';
  static const String UPDATE_MANERA_ENTREGA ='https://hbtknet.com/client/get_entrega-updated';
  static const String UPDATE_MANERA_PAGO ='https://hbtknet.com/client/get_pago-updated';














}