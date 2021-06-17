import 'package:kedu/core/models/userModel.dart';

class ChatModel {
  String _id;
  UserModel _chattingWith;
  DateTime _date;

  ChatModel(
      {required String id,
      required UserModel chattingWith,
      required DateTime date})
      : _id = id,
        _chattingWith = chattingWith,
        _date = date;

  DateTime get date => _date;

  UserModel get chattingWith => _chattingWith;

  String get id => _id;
}
