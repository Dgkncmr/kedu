import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kedu/external_lib/slide_popup_dialog.dart';
import 'package:kedu/my_flutter_app_icons.dart';
import 'package:kedu/ui/pages/chatPages/chatListPage.dart';
import 'package:kedu/ui/pages/parentPages/homePageParent.dart';
import 'package:kedu/ui/pages/teacherPages/homePageTeacher.dart';
import 'package:kedu/ui/pages/teacherPages/homeworkContentPageTeacher.dart';

class Assets {
  static Widget navBarTeacher(context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageTeacher(),
                )),
            icon: Icon(Icons.home_outlined),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.volume_mute_outlined,size: 32,),
            color: Colors.black87,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                showSlideDialog(
                  first: 1.3,
                  sec: 2,
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeworkContentPageTeacher(),
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    MyFlutterApp.homework,
                                    size: 32,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Ödev Ekle",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    MyFlutterApp.activity,
                                    size: 32,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Etkinlik Ekle",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  pillColor: null,
                );
              },
              backgroundColor: Color(0XFFFFAB5D),
              child: Icon(Icons.add),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatListPage(),
                )),
            icon: Icon(Icons.chat_bubble_outline),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline),
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  static Widget navBarParent(context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageParent(),
                )),
            icon: Icon(Icons.home_outlined),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.volume_mute_outlined,size: 32,),
            color: Colors.black87,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {},
              backgroundColor: Color(0XFFFFAB5D),
              child: Icon(Icons.add),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatListPage(),
                )),
            icon: Icon(Icons.chat_bubble_outline),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline),
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
