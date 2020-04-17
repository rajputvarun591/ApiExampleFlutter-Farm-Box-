import 'dart:async';
import 'dart:io' show Directory;

import 'dart:developer' as developer;
import 'package:farm_box/data_holder.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databaseName = 'farm_box';
  static final _version = 1;

  static final table = 'farm_box_data';

  static final columnId = 'id';
  static final columnUserId = 'user_id';
  static final columnAirHumidity = 'air_humidity';
  static final columnTemperature = 'temperature';
  static final columnSoilHumidity = 'soil_humidity';
  static final columnCarbonMonoOxide = 'carbon_mono_oxide';
  static final columnCreatedOn = 'created_on';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper() => instance;

  static Database _database;

  Future<Database> get database async{
    if(database != null) return database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    Directory _directory = await getApplicationDocumentsDirectory();
    String path = join(_directory.path, _databaseName);
    developer.log('Database Created Successfully');
    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE $table(
        $columnUserId INTEGER PRIMARY KEY,
        $columnId INTEGER NOT NULL,
        $columnAirHumidity TEXT NOT NULL,
        $columnTemperature TEXT NOT NULL,
        $columnSoilHumidity TEXT NOT NULL,
        $columnCarbonMonoOxide TEXT NOT NULL,
        $columnCreatedOn TEXT NOT NULL 
      )
    ''');
    developer.log('Table Cteated Successfully');
  }

  Future<int> saveData(DataHolder dataHolder) async{
    var dbClient = await database;
    return await dbClient.insert('$table', dataHolder.toMap());
  }

  Future<List> getData() async{
    var dbClient = await database;
    var result = await dbClient.rawQuery('SELECT * FROM $table');
    return result.toList();
  }

  Future<int> truncateTable() async{
    var dbClient = await database;
    return dbClient.delete('$table');
  }
}