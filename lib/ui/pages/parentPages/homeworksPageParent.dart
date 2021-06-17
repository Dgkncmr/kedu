import 'package:flutter/material.dart';
import 'package:kedu/core/models/homeworkModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/pages/parentPages/homeworkContentPageParent.dart';
import 'package:kedu/ui/pages/parentPages/uploadHomeworkPageParent.dart';

class HomeworksPageParent extends StatefulWidget {
  List<HomeworkModel> _homeworks;

  HomeworksPageParent(this._homeworks, {Key? key}) : super(key: key);

  @override
  _HomeworksPageParentState createState() => _HomeworksPageParentState();
}

class _HomeworksPageParentState extends State<HomeworksPageParent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: ProviderAccessor.instance.user.isTeacher
            ? Assets.navBarTeacher(context)
            : Assets.navBarParent(context),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ödevler",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._homeworks.length,
                    itemBuilder: (context, index) =>
                        _courseBox(widget._homeworks[index]),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _courseBox(HomeworkModel homework) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeworkContentPageParent(homework),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Colors.black54),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 12,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(Icons.bookmark),
              SizedBox(
                width: 8.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homework.subject,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    homework.description.length > 20
                        ? homework.description.substring(0, 20)
                        : homework.description,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
