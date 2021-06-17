import 'package:kedu/core/models/teacherModel.dart';
import 'package:kedu/core/models/userModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';

class StudentModel extends UserModel {
  String _classID;
  int _bookNumber;
  late TeacherModel _teacher;

  StudentModel({
    required String id,
    required String name,
    required String email,
    required DateTime birthday,
    required String ssn,
    required String address,
    required String classID,
    required int bookNumber,
  })  : this._classID = classID,
        this._bookNumber = bookNumber,
        super(id, name, email, birthday, ssn, address);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "birthday": birthday,
      "ssn": ssn,
      "address": address,
      "classID": _classID,
      "bookNumber": _bookNumber,
    };
  }

  setTeacher() async {
    _teacher = await FireStoreModule.getTeacher(this);
  }

  TeacherModel get teacher => _teacher;

  int get bookNumber => _bookNumber;

  String get classID => _classID;
}
