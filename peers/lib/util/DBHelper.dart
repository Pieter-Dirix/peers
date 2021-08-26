import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:peers/models/User.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _dbHelper = DBHelper._internal();

  String tblUser = "USER";
  String colId = "id";
  String colFirstname = "firstname";
  String colLastname = "lastname";
  String colEmail = "email";
  String colGender = "gender";
  String colSchool = "school";
  String colBio = "bio";
  String colEvents = "events";
  DBHelper._internal();

  factory DBHelper() {
    return _dbHelper;
  }

  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDB();
    }
    return _db!;
  }

  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), "user_database.db");
    var dbUsers = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE USER ($colId STRING PRIMARY KEY, $colFirstname TEXT, " +
              "$colLastname TEXT, $colEmail TEXT, $colGender TEXT, $colSchool TEXT, $colBio TEXT, $colEvents TEXT )");
    });
    return dbUsers;
  }

  // Future<User> getUser(User user)  async  {
  //   Database db = await this.db;
  //   List<Map> result = await db.rawQuery('SELECT * FROM $tblUser WHERE id=?', [user.id]);
  //
  //   if(result.length != 0) {
  //     return user;
  //   }else {
  //
  //   }
  // }

  Future<bool> checkIfUserExists(User user) async {
    Database db = await this.db;
    List<Map> result =
        await db.rawQuery('SELECT * FROM $tblUser WHERE id=?', [user.id]);

    if (result.length != 0) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  Future<User> getUser() async {
    final storage = new FlutterSecureStorage();
    String? id = await storage.read(key: "id");
    Database db = await this.db;
    try {

      List<Map> result =
          await db.rawQuery('SELECT * FROM $tblUser WHERE id=?', [id]);

      return Future<User>.value(User.fromLocalDB(result[0]));
    } catch (e) {
      print(e.toString());
      throw ("Getting user failed");
    }
  }

  Future<void> insertUser(User user) async {
    Database db = await this.db;
    final bool exists = await checkIfUserExists(user);
    if (!exists) {
      await db.insert(tblUser, user.toLocalDB());
    }
  }

  Future<bool> removeUser(User user) async {
    Database db = await this.db;
    final storage = new FlutterSecureStorage();
    await storage.write(key: "accessToken", value: null);
    try {
      int result =
          await db.rawDelete('DELETE FROM $tblUser WHERE id=?', [user.id]);


      if (result == 1) {
        return Future<bool>.value(true);
      }
    } catch (e) {
      throw('Logging out failed ${e.toString()}');
    }
    return Future<bool>.value(false);
  }
}
