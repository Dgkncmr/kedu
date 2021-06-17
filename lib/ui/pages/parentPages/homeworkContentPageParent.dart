import 'package:flutter/material.dart';
import 'package:kedu/core/models/homeworkModel.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/assets/Colors.dart';

class HomeworkContentPageParent extends StatefulWidget {
  HomeworkModel _homework;

  HomeworkContentPageParent(this._homework, {Key? key}) : super(key: key);

  @override
  _HomeworkContentPageParentState createState() =>
      _HomeworkContentPageParentState();
}

class _HomeworkContentPageParentState extends State<HomeworkContentPageParent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: _body(),
        bottomNavigationBar: Assets.navBarParent(context),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(32),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios)),
                      Text(
                        widget._homework.subject,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                      widget._homework.description),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget notes() {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        minHeight: 70,
      ),
      decoration: BoxDecoration(
        color: Color(0XFF646464).withOpacity(0.1),
        border: Border.all(width: 0.5, color: Colors.black54),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            constraints: BoxConstraints(
              minHeight: 70,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Not!",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              Text(
                "Ders Kitabından sayfa 123, 124'te ya",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
