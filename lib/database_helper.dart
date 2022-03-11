import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/task_model.dart';

class DatabaseHelper {
  DatabaseHelper();

  static final DatabaseHelper instance = DatabaseHelper();
  static Database? _database;
  Future<Database> get database async => _database ?? await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'customer.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
CREATE TABLE customer(
  id INTEGER PRIMARY KEY,
  title TEXT,
  description TEXT
  
)
  
""");
  }

  Future<int> insertTask(CustomerModel customerModel) async {
    Database db = await instance.database;
    return await db.insert("customer", customerModel.toMap());
  }

  Future<List<CustomerModel>> getTask() async {
    Database db = await instance.database;
    var customer = await db.query("customer", orderBy: "id");

    List<CustomerModel> taskList = customer.isNotEmpty
        ? customer.map((data) => CustomerModel.fromMap(data)).toList()
        : [];

    return taskList;
  }

  Future<int> deleteTask(int id) async {
    Database db = await instance.database;
    return await db.delete("customer", where: "id=?", whereArgs: [id]);
  }
  Future<int>updateTask(CustomerModel customerModel)async{
    Database db=await instance.database;
    return await db.update("customer", customerModel.toMap(),
    where: "id=?",
    whereArgs: [customerModel.id]
    );
  }





}
