import 'package:flutter/material.dart';
import 'package:kedu/core/models/homeworkModel.dart';
import 'package:kedu/core/models/studentModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/core/providers/userProvider.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/parentPages/homeworksPageParent.dart';
import 'package:kedu/ui/pages/signUpPages/signUpPage.dart';

import 'homeworkContentPageParent.dart';

class HomePageParent extends StatefulWidget {
  const HomePageParent({Key? key}) : super(key: key);

  @override
  _HomePageParentState createState() => _HomePageParentState();
}

class _HomePageParentState extends State<HomePageParent> {
  StudentModel student = ProviderAccessor.instance.user.user as StudentModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Assets.navBarParent(context),
        backgroundColor: AppColors.backgroundColor,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _profileBox(),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _homeWorkListBox(),
          ),
        ],
      ),
    );
  }

  Widget _homeWorkListBox() {
    return FutureBuilder(
      future: FireStoreModule.listHomeworks(student.classID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Material(
            borderRadius: BorderRadius.circular(32),
            elevation: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 32,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          "Ödevler",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeworksPageParent(
                                  snapshot.data as List<HomeworkModel>),
                            ),
                          ),
                          child: Text(
                            "Tümünü Gör",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if ((snapshot.data as List).isNotEmpty)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (snapshot.data as List).length < 3
                          ? (snapshot.data as List).length
                          : 3,
                      itemBuilder: (context, index) =>
                          _courseBox((snapshot.data as List)[index]),
                    )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
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

  Widget _profileBox() {
    return Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 6,
      child: Container(
        width: MediaQuery.of(context).size.width,
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
                Icon(Icons.menu),
              ],
            ),
            Container(
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
            SizedBox(
              height: 8.0,
            ),
            Text(
              student.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("Öğretmen"),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(student.teacher.name),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("Okuduğu Kitap"),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(student.bookNumber.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("Sınıf"),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(student.classID),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
