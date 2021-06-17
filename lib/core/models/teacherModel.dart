import 'package:kedu/core/models/userModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';

class TeacherModel extends UserModel {
  String _homePhone;
  String _phone;
  List _classIDs;
  int? _studentNumber;
  int _weeklyLessonHours;

  TeacherModel(
      {required String id,
      required String name,
      required String email,
      required DateTime birthday,
      required String ssn,
      required String address,
      required String homePhone,
      required String phone,
      required List classIDs,
      required int weeklyLessonHours})
      : this._homePhone = homePhone,
        this._phone = phone,
        this._classIDs = classIDs,
        this._weeklyLessonHours = weeklyLessonHours,
        super(id, name, email, birthday, ssn, address);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "birthday": birthday,
      "ssn": ssn,
      "address": address,
      "homePhone": homePhone,
      "phone": phone,
      "classIDs": classIDs,
      "studentNumber": studentNumber,
      "weeklyLessonHours": weeklyLessonHours
    };
  }

  calculateStudents() async {
    _studentNumber = (await FireStoreModule.listStudents(this)).length;
  }

  int get weeklyLessonHours => _weeklyLessonHours;

  int get studentNumber => _studentNumber ?? 0;

  List get classIDs => _classIDs;

  String get phone => _phone;

  String get homePhone => _homePhone;
}
