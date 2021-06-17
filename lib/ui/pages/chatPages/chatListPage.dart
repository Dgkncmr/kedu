import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kedu/core/models/chatModel.dart';
import 'package:kedu/core/models/studentModel.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/core/providers/chatProvider.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/pages/chatPages/chatCreatePage.dart';
import 'package:kedu/ui/pages/chatPages/chatPage.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  ChatProvider chatProvider = ProviderAccessor.instance.chat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF2F6FA),
      appBar: appBar(),
      floatingActionButton: floatActionButton(),
      bottomNavigationBar: chatProvider.user.isTeacher
          ? Assets.navBarTeacher(context)
          : Assets.navBarParent(context),
      body: body(),
    );
  }

  PreferredSizeWidget appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(116),
      child: AppBar(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 14, bottom: 14, left: 24, right: 24),
                        child: Text(
                          "Aktif Sohbetler",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0XFF0041FD),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: chatProvider.chats.length,
      itemBuilder: (context, index) => chatBox(chatProvider.chats[index]),
    );
  }

  Widget chatBox(ChatModel chat) {
    final DateFormat formatter = DateFormat('Hm');
    String time = formatter.format(chat.date);
    String subText = chat.chattingWith.isTeacher
        ? "Sınıf Öğretmeni"
        : "${(chat.chattingWith as StudentModel).classID} Sınıfı Öğrencisi";
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(chat.chattingWith),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 8, right: 8),
                child: Container(
                  child: Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.white,
                  ),
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      chat.chattingWith.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Text(
                    subText,
                    style: TextStyle(fontSize: 10, color: Color(0XFFB0B1B6)),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /*Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "2",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0XFFCC3E3E),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),*/
                    Text(
                      time,
                      style: TextStyle(fontSize: 8, color: Color(0XFFB0B1B6)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget floatActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0XFFFFBE2C),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatCreatePage(),
            ));
      },
      child: Icon(Icons.message),
    );
  }
}
