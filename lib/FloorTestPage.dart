import 'package:flutter/material.dart';
import 'dao/DBService.dart';
import 'dao/bean/User.dart';
import 'dao/bean/Work.dart';

class FloorTestPage extends StatefulWidget {
  @override
  _FloorTestPageState createState() => _FloorTestPageState();
}

class _FloorTestPageState extends State<FloorTestPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor 框架测试'),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){

            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Text('读数据库'),
            ),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: '输入名称'),
            onSubmitted: (v) {
              getUserDao().then((dao) {
                dao.insertUser(User(id: controller.text, name: controller.text));
            });

//              getDao().then((dao) {
//                dao.insertWork(Work(
//                    name: controller.text,
//                    createTime: DateTime.now().toString().substring(0, 19)));
//                controller.clear();
//              });
            },
          ),
          GestureDetector(
            onTap: (){
              getUserDao().then((dao) {
//                dao.updateUserId(User(id: controller.text));
              });
            },
            child: Text(
                '修改name'
            ),
          ),
//          FutureBuilder(
////            future: getDao(),
////            builder: (c, s) {
////              print('state ${s.connectionState}');
////              if (s.connectionState == ConnectionState.done) {
////                WorkDao dao = s.data;
////                return Expanded(
////                  child: StreamBuilder(
////                    stream: dao.findAllWorksAsStream(),
////                    builder: (c, s) {
////                      print('connection state:${s.connectionState}');
////                      if (s.connectionState == ConnectionState.active) {
////                        List<Work> works = s.data;
////                        return ListView.builder(
////                          itemCount: works.length,
////                          itemBuilder: (c, i) {
////                            Work work = works[i];
////                            return Dismissible(
////                              key: ValueKey(work.id),
////                              background: Container(
////                                color: Colors.red,
////                              ),
////                              child: ListTile(
////                                title: Text(work.name),
////                                subtitle: Text(work.createTime ?? ''),
////                              ),
////                              direction: DismissDirection.endToStart,
////                              onDismissed: (DismissDirection direction) {
////                                dao.deleteWork(work);
////                              },
////                            );
////                          },
////                        );
////                      } else if (s.connectionState == ConnectionState.waiting) {
////                        return Center(
////                          child: CircularProgressIndicator(),
////                        );
////                      } else {
////                        return Center(
////                          child: Text('其他'),
////                        );
////                      }
////                    },
////                    initialData: [],
////                  ),
////                );
////              } else if (s.connectionState == ConnectionState.waiting) {
////                return Center(
////                  child: CircularProgressIndicator(),
////                );
////              } else {
////                return Center(
////                  child: Text('可能出错了'),
////                );
////              }
////            },
////          )
          FutureBuilder(
            future: getUserDao(),
            builder: (c, s) {
              print('state ${s.connectionState}');
              if (s.connectionState == ConnectionState.done) {
                UserDao dao = s.data;
                return Expanded(
                  child: StreamBuilder(
                    stream: dao.findAllUsersAsStream(),
                    builder: (c, s) {
                      print('connection state:${s.connectionState}');
                      if (s.connectionState == ConnectionState.active) {
                        List<User> users = s.data;
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (c, i) {
                            User user = users[i];
                            return Dismissible(
                              key: ValueKey(user.id),
                              background: Container(
                                color: Colors.red,
                              ),
                              child: ListTile(
                                title: Text(user.name),
                                subtitle: Text(user.id),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                dao.deleteUser(user);
                              },
                            );
                          },
                        );
                      } else if (s.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Center(
                          child: Text('其他'),
                        );
                      }
                    },
                    initialData: [],
                  ),
                );
              } else if (s.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text('可能出错了'),
                );
              }
            },
          )
        ],
      ),
    );
  }

  WorkDao _dao;
  Future<WorkDao> getDao() async {
    if (_dao == null) {
      DBService dbService = await DBService.getInstance();
      _dao = await dbService.getWorkDao();
    }
    return _dao;
  }

  UserDao _userdao;
  Future<UserDao> getUserDao() async {
    if (_dao == null) {
      DBService dbService = await DBService.getInstance();
      _userdao = await dbService.getUserDao();
    }
    return _userdao;
  }
}
