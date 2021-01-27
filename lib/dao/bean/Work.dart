import 'package:floor/floor.dart';

@entity
class Work {
  @primaryKey
  final int id;

  final String name;

  @ColumnInfo(name: 'create_time', nullable: true)
  final String createTime;

  final String nickname2;
  final String nickname3;
//  final String nickname4;
//  final String nickname5;
//  final String nickname6;


  Work({this.id, this.name, this.createTime,this.nickname2,this.nickname3});
//  Work({this.id, this.name, this.createTime,this.nickname2,this.nickname3,this.nickname4,this.nickname5,this.nickname6});
}

@dao
abstract class WorkDao {
  @Query('SELECT * FROM Work')
  Future<List<Work>> findAllWorks();
  @Query('SELECT * FROM Work')
  Stream<List<Work>> findAllWorksAsStream(); // stream return
  @Query('SELECT * FROM Work WHERE id=:id')
  Future<List<Work>> findWorkById(int id);
  @insert
  Future<void> insertWork(Work work);
  @delete
  Future<int> deleteWorks(List<Work> person);
  @delete
  Future<void> deleteWork(Work work);
}