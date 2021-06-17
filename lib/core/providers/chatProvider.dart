import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:kedu/core/models/chatModel.dart';
import 'package:kedu/core/models/messageModel.dart';
import 'package:kedu/core/models/userModel.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/core/providers/userProvider.dart';

class ChatProvider extends ChangeNotifier {
  final DatabaseReference _db = FirebaseDatabase().reference().child("chats");
  final CollectionReference _chatsReference =
      FirebaseFirestore.instance.collection("chats");
  final CollectionReference _messagesReference =
      FirebaseFirestore.instance.collection("messages");
  late UserModel user;
  late UserProvider _userProvider;
  StreamController<List<MessageModel>> _messagesStreamController =
      StreamController.broadcast();
  StreamController<List<ChatModel>> _chatsStreamController =
      StreamController.broadcast();
  List<ChatModel> chats = [];
  List<MessageModel> messages = [];

  load() {
    _userProvider = ProviderAccessor.instance.user;
    user = _userProvider.user!;
  }

  Future<String?> isChattingWith(String userID) async {
    List<QueryDocumentSnapshot> chatDocuments = (await _chatsReference
            .where("participants", arrayContains: user.id)
            .get())
        .docs;
    Iterable chats = chatDocuments
        .where((element) => element["participants"].contains(userID));
    if (chats.isNotEmpty) {
      return chats.first.id;
    }
  }

  Future getMessages(String chatID) async {
    List<QueryDocumentSnapshot> messageDocuments = (await _messagesReference
            .where("chatID", isEqualTo: chatID)
            .orderBy("timestamp")
            .get())
        .docs;
    messages = [];
    messageDocuments.forEach((element) {
      messages.insert(
          0,
          MessageModel(
              sender: element["sender"],
              text: element["text"],
              timestamp:  DateTime.fromMillisecondsSinceEpoch(
                  (element["timestamp"] as Timestamp).millisecondsSinceEpoch)));
    });
    _messagesStreamController.add(messages);
  }

  Future getChats() async {
    if ((await _chatsReference.get()).docs.isNotEmpty) {
      chats = [];
      List<QueryDocumentSnapshot> chatDocuments = (await _chatsReference
              .where("participants", arrayContains: user.id)
              .orderBy("date", descending: true)
              .get())
          .docs;
      chatDocuments.forEach((element) {
        String userID = element["participants"]
            .where((element) => element != user.id)
            .first;

        chats.add(ChatModel(
            id: element.id,
            chattingWith: _userProvider.getUser(userID),
            date: DateTime.fromMillisecondsSinceEpoch(
                (element["date"] as Timestamp).millisecondsSinceEpoch)));
      });
    }
  }

  Future<bool> createChat(
      UserModel chattingWith, MessageModel initialMessage) async {
    if ((await isChattingWith(chattingWith.id)) == null) {
      DocumentSnapshot chatDocument = await (await _chatsReference.add({
        "participants": [chattingWith.id, user.id],
        "date": DateTime.now()
      }))
          .get();
      _addChat(ChatModel(
          id: chatDocument.id,
          chattingWith: chattingWith,
          date: DateTime.now()));
      sendMessage(chatDocument.id, initialMessage);
      return true;
    }
    return false;
  }

  Future sendMessage(String chatID, MessageModel message) async {
    Map data = message.toMap();
    data["chatID"] = chatID;
    _messagesReference.add(data);
    _chatsReference.doc(chatID).update({"date": DateTime.now()});
    _addMessage(chatID, message);
  }

  _addMessage(String chatID, MessageModel message) {
    messages.insert(0, message);
    _messagesStreamController.add(messages);
  }

  _addChat(ChatModel chat) {
    _chatsStreamController.add([chat]);
  }

  Stream<List<MessageModel>> get messagesStream =>
      _messagesStreamController.stream;
}
