import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kedu/core/models/teacherModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/external_lib/slide_popup_dialog.dart';
import 'package:kedu/my_flutter_app_icons.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/teacherPages/homePageTeacher.dart';

class HomeworkContentPageTeacher extends StatefulWidget {
  const HomeworkContentPageTeacher({Key? key}) : super(key: key);

  @override
  _HomeworkContentPageTeacherState createState() =>
      _HomeworkContentPageTeacherState();
}

class _HomeworkContentPageTeacherState
    extends State<HomeworkContentPageTeacher> {
  TeacherModel teacher = ProviderAccessor.instance.user.user as TeacherModel;
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedClass = "";
  List<Widget> classes = [];
  List<Widget> column = [];
  DateTime date = DateTime.now();
  bool firstSwitchVal = false;
  bool secSwitchVal = false;

  @override
  void initState() {
    initializeDateFormatting("tr-TR");
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
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: _body(),
        bottomNavigationBar: Assets.navBarTeacher(context),
      ),
    );
  }

  Widget classCircle(String classID) {
    return InkWell(
      onTap: () => setState(() {
        selectedClass = classID;
      }),
      child: Container(
        decoration: BoxDecoration(
          color: selectedClass == classID ? Colors.grey : Color(0XFFD58A8A),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(classID),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: TextField(
                        controller: subjectController,
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ödev Ekle...",
                          hintStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.home,
                          color: Color(0XFFFFAB5D),
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 8,
                  minLines: 1,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black87),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black87),
                    ),
                    hintText: "Yazı Ekle...",
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Column(
                  children: column,
                ),
                Spacer(),
                Row(
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        column.add(Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: notes(),
                        ));
                        setState(() {});
                      },
                      child: Icon(
                        Icons.notes,
                        color: Colors.black87,
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: () {},
                      child: Icon(
                        Icons.photo_outlined,
                        color: Colors.black87,
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    Spacer(),
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: () {},
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                      backgroundColor: Color(0XFFFFAB5D),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        showSlideDialog(
                          first: 4,
                          sec: 1,
                          context: context,
                          pillColor: null,
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("Etkinlik Son Tarihi"),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                        GestureDetector(
                                          onTap: () {
                                            DatePicker.showDatePicker(context,
                                                locale: LocaleType.tr,
                                                onChanged: (date) {
                                              setState(() {
                                                this.date = date;
                                              });
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: Colors.black26,
                                                  width: 2),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  DateFormat.yMMMd("tr-TR")
                                                      .format(date),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Icon(Icons.keyboard_arrow_down),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Yarın"),
                                      Switch(
                                          value: firstSwitchVal,
                                          onChanged: (value) {
                                            setState(() {
                                              if (firstSwitchVal) {
                                                firstSwitchVal = false;
                                              } else {
                                                firstSwitchVal = true;
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Bütün Gün"),
                                      Switch(
                                          value: secSwitchVal,
                                          onChanged: (value) {
                                            setState(() {
                                              if (secSwitchVal) {
                                                secSwitchVal = false;
                                              } else {
                                                secSwitchVal = true;
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Açıklama Kenarlığı Rengi"),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          constraints: BoxConstraints(
                                            minHeight: 70,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.black54),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                constraints: BoxConstraints(
                                                  minHeight: 70,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  16),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  16)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Color(0XFF2AE39E),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Color(0XFFA079EC),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Color(0XFFF1CA72),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Etkinliğin Verileceği Sınıf"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: Colors.black26,
                                                width: 2),
                                          ),
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: classes,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (await FireStoreModule
                                                .createHomework(
                                                    classID: selectedClass,
                                                    subject:
                                                        subjectController.text,
                                                    description:
                                                        descriptionController
                                                            .text,
                                                    deadline: date)) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePageTeacher()));
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 32),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: Colors.grey.shade300,
                                            ),
                                            child: Text(
                                              "Yükle",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                      child: Icon(
                        Icons.upload_file,
                      ),
                      backgroundColor: Color(0XFFFFAB5D),
                    ),
                  ],
                ),
              ],
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
