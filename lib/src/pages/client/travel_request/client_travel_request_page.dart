import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:order/src/pages/client/travel_request/client_travel_request_controller.dart';
import 'package:order/src/utils/colors.dart' as utils;
import 'package:order/src/widgets/button_app.dart';

class ClientTravelRequestPage extends StatefulWidget {
  @override
  _ClientTravelRequestPageState createState() => _ClientTravelRequestPageState();
}

class _ClientTravelRequestPageState extends State<ClientTravelRequestPage> {

  ClientTravelRequestController _con = new ClientTravelRequestController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              _driverInfo(),
              _lottieAnimation(),
              _textLookingFor(),
              _textCounter(),
            ],
          )
        ],
      ),
      bottomNavigationBar: _buttonCancel(_con.cancelTravel),
    );
  }

  Widget _buttonCancel(Function f) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(30),
      child: ButtonApp(
        onPressed: ()=>f(),
        text: 'Cancelar viaje',
        color: Colors.amber,
        icon: Icons.cancel_outlined,
        textColor: Colors.black
      ),
    );
  }

  Widget _textCounter() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Text(
        '0',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _lottieAnimation() {
    return Lottie.asset(
      'assets/json/car-control.json',
      width: MediaQuery.of(context).size.width * 0.70,
      height: MediaQuery.of(context).size.height * 0.35,
      fit: BoxFit.fill
    );
  }

  Widget _textLookingFor() {
    return Container(
      child: Text(
        'Buscando conductor',
        style: TextStyle(
          fontSize: 16
        ),
      ),
    );
  }

  Widget _driverInfo() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: utils.Colors.uberCloneColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/profile.jpg'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Tu Conductor',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  void refresh() {
    setState(() {});
  }
}
