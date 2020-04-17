import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:farm_box/data_holder.dart';
import 'package:farm_box/data_viewer.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FarmboxHome extends StatefulWidget {
  @override
  _FarmboxHomeState createState() => _FarmboxHomeState();
}

class _FarmboxHomeState extends State<FarmboxHome> {

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmBox'),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          //padding: EdgeInsets.all(50.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(40.00),
                child: Image.asset('assets/images/logo.png'),
              ),
              Card(
                margin: EdgeInsets.only(right: 40.00, left: 40.00),
                color: Colors.teal,
                child: FlatButton(
                    onPressed: () => _getAPI(2, context),
                    child: Text('Box 1', style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),
              Card(
                margin: EdgeInsets.only(right: 40.00, left: 40.00),
                color: Colors.teal,
                child: FlatButton(
                    onPressed: () => _getAPI(1, context),
                    child: Text('Box 2', style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              Card(
                margin: EdgeInsets.only(right: 40.00, left: 40.00),
                color: Colors.teal,
                child: FlatButton(
                    onPressed: () => _getAPI(0, context),
                    child: Text('Box 3',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        )
                    )
                ),
              ),
              Container(
                color: Colors.teal,
                padding: EdgeInsets.all(5.00),
                child: Align(
                    alignment: Alignment.bottomCenter ,
                    child: Text('Powered by: Indev Consultancy Pvt. Ltd.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.00
                        )
                    )
                ),
              ),
            ],
          ),
        );
      })
    );
  }

  //Method For hit the API and perform further operations
    Future _getAPI(int boxId, context) async{
/*
    Let Us assume there is no internet connection in the device,
     in this condition we have to check Connection om mobile
     either wifi and tell user by showing a SnackBar,
     There is a simple and Default SanckBar(see the bottom comment) given by Flutter,
     you can simply use it but is have some limitations so that
     I am using library of Flushbar here for more styles
*/  var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DataViewer(boxId: boxId, internetConnectivity: true,))); // send data with box ID to next screen so that we can check wich button was pressed
    }
    //If internet is available Show next screen
    else{
        print('Internet Connection not found On this device');
        /*return  Flushbar(
        message: 'Network Error !',
        icon: Icon(
          Icons.report_problem,
          size: 20,
          color: Colors.white70,
        ),
        //leftBarIndicatorColor: Colors.redAccent,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        animationDuration: Duration(milliseconds: 400),
      )..show(context);*/
      Navigator.push(context, MaterialPageRoute(builder: (context) => DataViewer(boxId: boxId, internetConnectivity: false,)));
    }// send data with box ID to next screen so that we can check wich button was pressed
  }
  //Method for perform an operation on clicking the SnackBar message(Not in use now)
  /*_openSettings() async {
    try{
      bool isInstalled = await DeviceApps.isAppInstalled('com.android.settings');
      print(isInstalled);
      await DeviceApps.openApp('com.android.settings');
    }catch(e){
      print('Application not found');
    }
  }*/
}//class body ends here
//Code for simple and default Snack bar given by Flutter
/*Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[Text("Can't connect to the Network"), Icon(Icons.report_problem,color: Colors.white70,)],),
            backgroundColor: Colors.redAccent,
            *//*duration: Duration(
                seconds: 0
            ),*//*
            //action: SnackBarAction(label: 'Settings',textColor: Colors.white, onPressed: _openSettings),
          )
      );*/