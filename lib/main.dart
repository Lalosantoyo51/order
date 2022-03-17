import 'package:flutter/material.dart';
import 'package:order/src/pages/client/edit/client_edit_page.dart';
import 'package:order/src/pages/client/history/client_history_page.dart';
import 'package:order/src/pages/client/history_detail/client_history_detail_page.dart';
import 'package:order/src/pages/client/map/client_map_page.dart';
import 'package:order/src/pages/client/travel_calification/client_travel_calification_page.dart';
import 'package:order/src/pages/client/travel_info/client_travel_info_page.dart';
import 'package:order/src/pages/client/travel_request/client_travel_request_page.dart';
import 'package:order/src/pages/driver/edit/driver_edit_page.dart';
import 'package:order/src/pages/driver/map/driver_map_page.dart';
import 'package:order/src/pages/driver/register/driver_register_page.dart';
import 'package:order/src/pages/driver/travel_calification/driver_travel_calification_page.dart';
import 'package:order/src/pages/driver/travel_request/driver_travel_request_page.dart';
import 'package:order/src/pages/driver/travel_map/driver_travel_map_page.dart';
import 'package:order/src/pages/home/home_page.dart';
import 'package:order/src/pages/login/login_page.dart';
import 'package:order/src/pages/client/register/client_register_page.dart';
import 'package:order/src/providers/push_notifications_provider.dart';
import 'package:order/src/utils/colors.dart' as utils;
import 'package:firebase_core/firebase_core.dart';
import 'package:order/src/pages/client/travel_map/client_travel_map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();
   pushNotificationsProvider.initPushNotifications();

   pushNotificationsProvider.message.listen((data) {

     print('------------NOTIFICACION NUEVA -------------');
     print(data);


     navigatorKey.currentState.pushNamed('driver/travel/request', arguments: data);
   });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Clone',
      navigatorKey: navigatorKey,
      initialRoute: 'home',
      theme: ThemeData(
          fontFamily: 'NimbusSans',
          appBarTheme: AppBarTheme(
              elevation: 0
          ),
          primaryColor: utils.Colors.uberCloneColor
      ),
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'login' : (BuildContext context) => LoginPage(),
        'client/register' : (BuildContext context) => ClientRegisterPage(),
        'driver/register' : (BuildContext context) => DriverRegisterPage(),
        'driver/map' : (BuildContext context) => DriverMapPage(),
        'driver/travel/request' : (BuildContext context) => DriverTravelRequestPage(),
        'driver/travel/map' : (BuildContext context) => DriverTravelMapPage(),
        'driver/travel/calification' : (BuildContext context) => DriverTravelCalificationPage(),
        'driver/edit' : (BuildContext context) => DriverEditPage(),
        'client/map' : (BuildContext context) => ClientMapPage(),
        'client/travel/info' : (BuildContext context) => ClientTravelInfoPage(),
        'client/travel/request' : (BuildContext context) => ClientTravelRequestPage(),
        'client/travel/map' : (BuildContext context) => ClientTravelMapPage(),
        'client/travel/calification' : (BuildContext context) => ClientTravelCalificationPage(),
        'client/edit' : (BuildContext context) => ClientEditPage(),
        'client/history' : (BuildContext context) => ClientHistoryPage(),
        'client/history/detail' : (BuildContext context) => ClientHistoryDetailPage(),
      },
    );
  }
}
