import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kedu/core/models/studentModel.dart';
import 'package:kedu/core/models/userModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/core/providers/userProvider.dart';
import 'package:kedu/ui/pages/chatPages/chatPage.dart';

class ChatCreatePage extends StatefulWidget {
  const ChatCreatePage({Key? key}) : super(key: key);

  @override
  _ChatCreatePageState createState() => _ChatCreatePageState();
}

class _ChatCreatePageState extends State<ChatCreatePage> {
  UserProvider userProvider = ProviderAccessor.instance.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  PreferredSizeWidget appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(88),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF0041FD),
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          children: [
                            TextSpan(
                                text: "Kedu",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "Chats")
                          ]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kişi Seç",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    iconSize: 32,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.tune),
                    iconSize: 32,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                    iconSize: 32,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: userProvider.users.length,
      itemBuilder: (context, index) => profileBox(userProvider.users[index]),
    );
  }

  Widget profileBox(UserModel user) {
    String subText = user is StudentModel
        ? "${user.classID} Sınıfı Öğrencisi"
        : "Sınıf Öğretmeni";
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(user),
            ));
      },
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
            child: Container(
              child: Icon(Icons.person, size: 48, color: Colors.white),
              height: 48,
              width: 48,
              decoration:
                  BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  user.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Text(
                subText,
                style: TextStyle(color: Color(0XFFB0B1B6), fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
