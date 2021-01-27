// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WorkDao _workDaoInstance;

  UserDao _userDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Work` (`id` INTEGER, `name` TEXT, `create_time` TEXT, `nickname2` TEXT, `nickname3` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` TEXT, `name` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WorkDao get workDao {
    return _workDaoInstance ??= _$WorkDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$WorkDao extends WorkDao {
  _$WorkDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _workInsertionAdapter = InsertionAdapter(
            database,
            'Work',
            (Work item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'create_time': item.createTime,
                  'nickname2': item.nickname2,
                  'nickname3': item.nickname3
                },
            changeListener),
        _workDeletionAdapter = DeletionAdapter(
            database,
            'Work',
            ['id'],
            (Work item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'create_time': item.createTime,
                  'nickname2': item.nickname2,
                  'nickname3': item.nickname3
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _workMapper = (Map<String, dynamic> row) => Work(
      id: row['id'] as int,
      name: row['name'] as String,
      createTime: row['create_time'] as String,
      nickname2: row['nickname2'] as String,
      nickname3: row['nickname3'] as String);

  final InsertionAdapter<Work> _workInsertionAdapter;

  final DeletionAdapter<Work> _workDeletionAdapter;

  @override
  Future<List<Work>> findAllWorks() async {
    return _queryAdapter.queryList('SELECT * FROM Work', mapper: _workMapper);
  }

  @override
  Stream<List<Work>> findAllWorksAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Work',
        queryableName: 'Work', isView: false, mapper: _workMapper);
  }

  @override
  Future<List<Work>> findWorkById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Work WHERE id=?',
        arguments: <dynamic>[id], mapper: _workMapper);
  }

  @override
  Future<void> insertWork(Work work) async {
    await _workInsertionAdapter.insert(work, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteWorks(List<Work> person) {
    return _workDeletionAdapter.deleteListAndReturnChangedRows(person);
  }

  @override
  Future<void> deleteWork(Work work) async {
    await _workDeletionAdapter.delete(work);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, dynamic>{'id': item.id, 'name': item.name},
            changeListener),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, dynamic>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userMapper = (Map<String, dynamic> row) =>
      User(id: row['id'] as String, name: row['name'] as String);

  final InsertionAdapter<User> _userInsertionAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User', mapper: _userMapper);
  }

  @override
  Stream<List<User>> findAllUsersAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM User',
        queryableName: 'User', isView: false, mapper: _userMapper);
  }

  @override
  Future<List<User>> findUserById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM User WHERE id=?',
        arguments: <dynamic>[id], mapper: _userMapper);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteUsers(List<User> person) {
    return _userDeletionAdapter.deleteListAndReturnChangedRows(person);
  }

  @override
  Future<void> deleteUser(User user) async {
    await _userDeletionAdapter.delete(user);
  }
}
