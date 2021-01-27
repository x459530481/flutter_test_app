import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_test_app/dao/bean/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'bean/Work.dart';

part 'AppDatabase.g.dart';

@Database(version: 3,entities: [Work,User])
abstract class AppDatabase extends FloorDatabase{
  WorkDao  get workDao;
  UserDao  get userDao;
}