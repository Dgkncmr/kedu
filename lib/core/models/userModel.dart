import 'package:kedu/core/models/teacherModel.dart';

abstract class UserModel {
  String _id;
  String _name;
  String _email;
  DateTime _birthday;
  String _ssn;
  String _address;

  UserModel(
    this._id,
    this._name,
    this._email,
    this._birthday,
    this._ssn,
    this._address,
  );

  @override
  String toString() {
    return 'UserModel{_id: $_id, _name: $_name, _email: $_email, _birthday: $_birthday, _ssn: $_ssn, _address: $_address}';
  }

  bool get isTeacher => this is TeacherModel;

  String get address => _address;

  String get ssn => _ssn;

  DateTime get birthday => _birthday;

  String get email => _email;

  String get name => _name;

  String get id => _id;
}
