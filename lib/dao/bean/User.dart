import 'package:floor/floor.dart';

@entity
class User {
  @primaryKey
  final String id;

  final String name;


  User({this.id, this.name});
//  Work({this.id, this.name, this.createTime,this.nickname2,this.nickname3,this.nickname4,this.nickname5,this.nickname6});
}

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUsers();
  @Query('SELECT * FROM User')
  Stream<List<User>> findAllUsersAsStream(); // stream return
  @Query('SELECT * FROM User WHERE id=:id')
  Future<List<User>> findUserById(int id);
  @insert
  Future<void> insertUser(User user);
  @delete
  Future<int> deleteUsers(List<User> person);
  @delete
  Future<void> deleteUser(User user);
//  @Update(OnConflictStrategy.ignore)
//  Future<void> updateUserId(User user);
}