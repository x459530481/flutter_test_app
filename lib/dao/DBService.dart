import 'package:floor/floor.dart';
import 'AppDatabase.dart';
import 'bean/User.dart';
import 'bean/Work.dart';

//final dbService = DBService();

class DBService {
  static AppDatabase dataBase;

  static DBService _instance;

  static Future<DBService> getInstance() async{
    if (_instance == null) {
      _instance = DBService();
      await initDataBase();
    }
    return _instance;
  }

  AppDatabase getDataBase(){
    return dataBase;
  }

//  DBService() {
//    if(dataBase == null){
//      print('DBService!!!!!!!');
//      initDataBase();
//    }
//  }

  static final callback = Callback(
    onCreate: (database, version) { /* database has been created */ },
    onOpen: (database) { /* database has been opened */ },
    onUpgrade: (database, startVersion, endVersion) {
      /* database has been upgraded */
      print(startVersion.toString() + 'callback onUpgrade!!!!!!!'+endVersion.toString());
    },
  );

  static initDataBase() async{
    print('initDataBase!!!!!!!');
    if(dataBase == null) {
      dataBase = await $FloorAppDatabase
          .databaseBuilder('app_database.db')
          .addMigrations([migration1to2,migration2to3])
//          .addCallback(callback)
          .build();
    }
    return dataBase;
  }

//  , migration2to3, migration3to4, migration4to5, migration5to6

  static final migration1to2 = Migration(1, 2, (database) async {
    print('migration1to2!!!!!!!');
    await database.execute('ALTER TABLE Work ADD COLUMN nickname2 TEXT');
  });

  static final migration2to3 = Migration(2, 3, (database) async {
    print('migration2to3!!!!!!!');
    await database.execute('ALTER TABLE Work ADD COLUMN nickname3 TEXT');
  });

  static final migration3to4 = Migration(3, 4, (database) async {
    print('migration3to4!!!!!!!');
    await database.execute('ALTER TABLE Work ADD COLUMN nickname4 TEXT');
  });

  static final migration4to5 = Migration(4, 5, (database) async {
    print('migration4to5!!!!!!!');
    await database.execute('ALTER TABLE Work ADD COLUMN nickname5 TEXT');
  });

  static final migration5to6 = Migration(5, 6, (database) async {
    print('migration5to6!!!!!!!');
    await database.execute('ALTER TABLE Work ADD COLUMN nickname6 TEXT');
  });

  Future<WorkDao> getWorkDao() async {
    return dataBase.workDao;
  }

  Future<UserDao> getUserDao() async {
    return dataBase.userDao;
  }
}