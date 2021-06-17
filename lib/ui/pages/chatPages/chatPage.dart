import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kedu/core/models/messageModel.dart';
import 'package:kedu/core/models/userModel.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/core/providers/chatProvider.dart';

class ChatPage extends StatefulWidget {
  final UserModel _targetUser;

  const ChatPage(UserModel targetUser, {Key? key})
      : _targetUser = targetUser,
        super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatProvider chatProvider = ProviderAccessor.instance.chat;
  final TextEditingController textEditingController = TextEditingController();
  String? chatID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Color(0XFFF2F6FA),
      body: body(),
    );
  }

  PreferredSizeWidget appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(116),
      child: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Color(0XFFF2F6FA),
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Kedu",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "Chats")
                          ]),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ))
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: Colors.white,
                      ),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: Colors.black12, shape: BoxShape.circle),
                    ),
                  ),
                  Text(
                    widget._targetUser.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Divider(
                  thickness: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<String?>(
              future: chatProvider.isChattingWith(widget._targetUser.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  chatID = snapshot.data!;
                  chatProvider.getMessages(snapshot.data!);
                  return StreamBuilder<List<MessageModel>>(
                      stream: chatProvider.messagesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) =>
                                messageBox(snapshot.data![index]),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                }
                return Center();
              }),
        ),
        _messageTextField()
      ],
    );
  }

  Widget _messageTextField() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: TextFormField(
                  controller: textEditingController,
                  maxLines: 7,
                  minLines: 1,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    fillColor: Colors.blue,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (chatID != null) {
                await chatProvider.sendMessage(
                    chatID!,
                    MessageModel(
                        sender: chatProvider.user.id,
                        text: textEditingController.text,
                        timestamp: DateTime.now()));
                textEditingController.clear();
                await chatProvider.getChats();
              } else {
                await chatProvider.createChat(
                    widget._targetUser,
                    MessageModel(
                        sender: chatProvider.user.id,
                        text: textEditingController.text,
                        timestamp: DateTime.now()));
                await chatProvider.getChats();
                textEditingController.clear();
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFFFFAB5D),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageBox(MessageModel message) {
    return chatProvider.user.id == message.sender
        ? sendMessageBox(message)
        : receiveMessageBox(message);
  }

  Widget sendMessageBox(MessageModel message) {
    final DateFormat formatter = DateFormat('Hm');
    String time = formatter.format(message.timestamp);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0XFF0041FD),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      )),
                ),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 8, color: Color(0XFF838890)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget receiveMessageBox(MessageModel message) {
    final DateFormat formatter = DateFormat('Hm');
    String time = formatter.format(message.timestamp);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(color: Color(0XFF767A82)),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      )),
                ),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 8, color: Color(0XFF838890)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
