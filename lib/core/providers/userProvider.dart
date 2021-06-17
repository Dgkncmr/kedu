import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:kedu/core/models/studentModel.dart';
import 'package:kedu/core/models/teacherModel.dart';
import 'package:kedu/core/models/userModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  List<UserModel> _users = [];
  StreamController<List<UserModel>> _usersStreamController =
      StreamController.broadcast();

  UserModel getUser(String id) {
    return users.where((element) => element.id == id).single;
  }

  Future getUsers() async {
    if (user!.isTeacher) {
      _users = await FireStoreModule.listStudents(user! as TeacherModel);
    } else {
      _users = [await FireStoreModule.getTeacher(user! as StudentModel)];
    }
    _usersStreamController.add(users);
  }

  Stream<List<UserModel>> get usersStream => _usersStreamController.stream;

  List<UserModel> get users => _users;

  bool get isTeacher => user!.isTeacher;
}
