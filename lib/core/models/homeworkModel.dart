class HomeworkModel {
  String _id;
  String _classID;
  String _subject;
  String _description;
  String? _note;
  DateTime _deadline;
  bool _submitted;

  HomeworkModel(
      {required id,
      required String classID,
      required String subject,
      required String description,
      String? note,
      required DateTime deadline,
      required bool submitted})
      : _id = id,
        _classID = classID,
        _subject = subject,
        _description = description,
        _note = note,
        _deadline = deadline,
        _submitted = submitted;

  bool get submitted => _submitted;

  DateTime get deadline => _deadline;

  String? get note => _note;

  String get description => _description;

  String get subject => _subject;

  String get classID => _classID;

  String get id => _id;
}
