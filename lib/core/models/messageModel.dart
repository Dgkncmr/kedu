class MessageModel {
  String _sender;
  String _text;
  DateTime _timestamp;

  MessageModel(
      {required String sender,
      required String text,
      required DateTime timestamp})
      : _sender = sender,
        _text = text,
        _timestamp = timestamp;

  MessageModel.fromMap(Map message)
      : _sender = message["sender"],
        _text = message["text"],
        _timestamp = message["timestamp"];

  DateTime get timestamp => _timestamp;

  String get text => _text;

  String get sender => _sender;

  Map<String, dynamic> toMap() {
    return {"sender": _sender, "text": _text, "timestamp": _timestamp};
  }

  @override
  String toString() {
    return 'MessageModel{_sender: $_sender, _text: $_text, _timestamp: $_timestamp}';
  }
}
