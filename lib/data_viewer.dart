import 'dart:convert';

import 'package:farm_box/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'data_holder.dart';
class DataViewer extends StatefulWidget {
  final int boxId;
  final bool internetConnectivity;
  DataViewer({@required this.boxId, this.internetConnectivity});

  @override
  _DataViewerState createState() => _DataViewerState();
}

class _DataViewerState extends State<DataViewer> {

  Future<dynamic> dataHolder;

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    dataHolder = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Farmbox Details'),
        ),
        body: FutureBuilder(
            future: dataHolder,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(40.00),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Container(
                        child: Text('Last Updated On: ' +
                            snapshot.data[widget.boxId].createdOn),
                      ),
                      Card(
                        margin: EdgeInsets.only(right: 40.00, left: 40.00),
                        color: Colors.teal,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/air_humidity.png', width: 40.00,
                            height: 40.00,),
                          title: Text(
                              'Air Humidity', style: TextStyle(color: Colors
                              .white)),
                          trailing: Text(
                              snapshot.data[widget.boxId].airHumidity,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(right: 40.00, left: 40.00),
                        color: Colors.teal,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/temperature.png', width: 40.00,
                            height: 40.00,),
                          title: Text(
                              'Temperature', style: TextStyle(color: Colors
                              .white)),
                          trailing: Text(
                              snapshot.data[widget.boxId].temperature,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(right: 40.00, left: 40.00),
                        color: Colors.teal,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/soil_humidity.png', width: 40.00,
                            height: 40.00,),
                          title: Text(
                              'Soil Humidity', style: TextStyle(color: Colors
                              .white)),
                          trailing: Text(
                              snapshot.data[widget.boxId].soilHumidity,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(right: 40.00, left: 40.00),
                        color: Colors.teal,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/co_2.png', width: 40.00,
                            height: 40.00,),
                          title: Text('Carbon Mono Oxide',
                              style: TextStyle(color: Colors.white)),
                          trailing: Text(
                              snapshot.data[widget.boxId].carbonMonoOxide,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        color: Colors.teal,
                        child: Align(alignment: Alignment.bottomCenter,
                            child: Text(
                                'Powered by: Indev Consultancy Pvt. Ltd.',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                );
              }
              else if (snapshot.hasError) {
                print('Error');
                return Text("${snapshot.error}");
              }
              return Center(
                child: SpinKitThreeBounce(color: Colors.teal),
              );
            })
    );
  }

  Future _fetchData() async {
    if(widget.internetConnectivity){
      var url = 'your URL';
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body); //convert data into json with JSONDecode method
        if(jsonData != null){ return _saveData(jsonData);}
      }
      else {
        // If that call was not successful, throw an error.
        print('Error: Something went wrong');
        throw Exception('Failed to load data');
      }
    }
    else{
      print('else block');
      print(databaseHelper.getData());
      return await databaseHelper.getData();
    }
  }
  Future _saveData(List<dynamic> jsonData) async{
    List<DataHolder> currentDataHolder = jsonData.map((f) => DataHolder.fromJson(f)).toList(); //hold data in PODO for save in database
    print(currentDataHolder);
    //List getData = await databaseHelper.getData();
    print(await databaseHelper.getData());
    /*if(getData != null)
      {
        await databaseHelper.truncateTable();
        print('Data Deleted');
      } */// if old data is there just delete this
    //for(int i = 0; i < currentDataHolder.length; i++){ databaseHelper.saveData(currentDataHolder[i]);} // finally save this data into database
    return jsonData.map((f) => DataHolder.fromJson(f)).toList(); //return current data
  }
  
}

