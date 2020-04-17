class DataHolder{
  int id;
  int userId;
  String airHumidity;
  String temperature;
  String soilHumidity;
  String carbonMonoOxide;
  String createdOn;

  DataHolder({this.id, this.userId, this.airHumidity, this.temperature,
      this.soilHumidity, this.carbonMonoOxide, this.createdOn});


  DataHolder.fromJson(Map<String, dynamic> data):
        id = int .parse(data['id']),
        userId = int .parse(data['user_id']),
        airHumidity = data['air_humidity'],
        temperature = data['tempreture'],
        carbonMonoOxide = data['carbon_mono_oxide'],
        soilHumidity = data['soil_humidity'],
        createdOn = data['created_on'];

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['air_humidity'] = airHumidity;
    map['tempreture'] = temperature;
    map['soil_humidity'] = soilHumidity;
    map['carbon_mono_oxide'] = carbonMonoOxide;
    map['created_on'] = createdOn;
    if(id != null) {map['id'] = id;}
    if(userId != null) {map['user_id'] = userId;}
    return map;
  }
}

/*
class DataHolderList{
  final List<DataHolder> dataHolderList;

  DataHolderList({this.dataHolderList});

  factory DataHolderList.fromJson(List<dynamic> data){
    List<DataHolder> list = new List<DataHolder>();
    list = data.map((f) => DataHolder.fromJson(f)).toList();
    return DataHolderList(
      dataHolderList : list
    );
  }
}*/
