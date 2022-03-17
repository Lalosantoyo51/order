import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:order/src/providers/client_provider.dart';
import 'package:order/src/providers/driver_provider.dart';
import 'package:order/src/utils/shared_pref.dart';

class PushNotificationsProvider {
  //FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  StreamController _streamController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get message => _streamController.stream;


  void initPushNotifications() async {

    // ON LAUNCH
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        Map<String, dynamic> data = message.data;
        SharedPref sharedPref = new SharedPref();
        sharedPref.save('isNotification', 'true');
        _streamController.sink.add(data);
      }
    });

    // ON MESSAGE
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      Map<String, dynamic> data = message.data;

      print('Cuando estamos en primer plano');
      print('OnMessage: $data');
      _streamController.sink.add(data);

    });

    // ON RESUME
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Map<String, dynamic> data = message.data;
      print('OnResume $data');
      _streamController.sink.add(data);
    });

  }

  void saveToken(String idUser, String typeUser) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String token = await messaging.getToken();
    print('hola token $token');
    Map<String,dynamic> data = {
      'token': token,
    };

    if(typeUser == 'client'){
      ClientProvider clientProvider = new ClientProvider();
      clientProvider.update(data, idUser);
    }
    else{
      DriverProvider driverProvider = new DriverProvider();
      driverProvider.update(data, idUser);
    }
  }
  Future <void> sendMessage(String to, Map<String, dynamic> data, String title, String body) async {
    await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send',),
        headers: <String , String>{
          'Content-Type' : 'application/json',
          'Authorization' : 'key=AAAAI9S2Z_o:APA91bEBF25BxWk1UdOz9F8ZjTK4ZTxbKr0rbrbpFud-1AJ-wD-md363D6HQThcLczcGzr9emAZl9aUUmQIfqnRl_pYy7S85cbZxwx2fFE_1kPxR2S6GoQKVsr73ynivv_bu1LMKDL_Y',
        },
        body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'ttl': '4500s',
              'data': data,
              'to': to,
            }
        )
    );
  }

  void dispose(){
    _streamController?.onCancel;
  }

}