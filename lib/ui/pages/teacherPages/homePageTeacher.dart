import 'package:flutter/material.dart';
import 'package:kedu/core/models/homeworkModel.dart';
import 'package:kedu/core/models/teacherModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/parentPages/homeworksPageParent.dart';
import 'package:kedu/ui/pages/signUpPages/signUpPage.dart';

class HomePageTeacher extends StatefulWidget {
  const HomePageTeacher({Key? key}) : super(key: key);

  @override
  _HomePageTeacherState createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  TeacherModel teacher = ProviderAccessor.instance.user.user as TeacherModel;
  String? selectedClass;
  List<Widget> classes = [];

  @override
  void initState() {
    teacher.classIDs.forEach((element) {
      classes.add(classCircle(element));
    });
    selectedClass = teacher.classIDs[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Assets.navBarTeacher(context),
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
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _homeWorkListBox() {
    return FutureBuilder(
        future: FireStoreModule.listHomeworks(selectedClass!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(32),
                  elevation: 6,
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: classes,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Material(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ödevler",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "$selectedClass sınıfı için verdiğiniz son ödevler",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black54),
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeworksPageParent(snapshot.data as List<HomeworkModel>),
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
                            itemCount: (snapshot.data as List).length > 3 ? 3 : (snapshot.data as List).length,
                            itemBuilder: (context, index) =>
                                _courseBox((snapshot.data as List)[index]),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget classCircle(String classID) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedClass = classID;
        });
      },
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Color(0XFFB8DA82),
        child: Text(
          classID,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _courseBox(HomeworkModel homework) {
    return GestureDetector(
      onTap: () {},
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
                Spacer(),
                Icon(Icons.settings_outlined),
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
              teacher.name,
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
                        Text("Sınıf Sayısı"),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(teacher.classIDs.length.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("Öğrenci Sayısı"),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(teacher.studentNumber.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("Haftalık Ders"),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(teacher.weeklyLessonHours.toString()),
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
