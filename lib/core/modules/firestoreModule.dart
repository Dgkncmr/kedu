import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kedu/core/models/homeworkModel.dart';
import 'package:kedu/core/models/studentModel.dart';
import 'package:kedu/core/models/teacherModel.dart';
import 'package:kedu/core/modules/firebaseAuthModule.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:kedu/core/providers/userProvider.dart';

class FireStoreModule {
  static FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;
  static UserProvider _userProvider = ProviderAccessor.instance.user;

  static Future<bool> createHomework(
      {required String classID,
      required String subject,
      required String description,
      String? note,
      required DateTime deadline}) async {
    if (_userProvider.user!.isTeacher) {
      await _firebaseStorage.collection("homeworks").add({
        "classID": classID,
        "subject": subject,
        "description": description,
        "note": note,
        "deadline": deadline,
        "submitted_students": []
      });
      return true;
    }
    return false;
  }

  static Future<List<HomeworkModel>> listHomeworks(String classID,
      {String? studentID}) async {
    List<QueryDocumentSnapshot> homeworkDocuments = (await _firebaseStorage
            .collection("homeworks")
            .where("classID", isEqualTo: classID)
            .orderBy("deadline", descending: true)
            .get())
        .docs;
    bool isSubmitted = false;
    if (homeworkDocuments.isNotEmpty) {
      List<HomeworkModel> homeworks = [];
      homeworkDocuments.forEach((element) {
        if (studentID != null)
          isSubmitted = (element["submitted_students"] as List)
              .where((element) => element == studentID)
              .isNotEmpty;
        homeworks.add(HomeworkModel(
            id: element.id,
            classID: classID,
            subject: element["subject"],
            description: element["description"],
            deadline: DateTime.fromMillisecondsSinceEpoch(
                (element["deadline"] as Timestamp).millisecondsSinceEpoch),
            submitted: isSubmitted));
      });
      return homeworks;
    }
    return [];
  }

  static Future<bool> createTeacher(Map teacherMap) async {
    bool isExists = (await _firebaseStorage
            .collection("teachers")
            .where("email", isEqualTo: teacherMap["email"])
            .get())
        .docs
        .isNotEmpty;
    if (!isExists &&
        await FirebaseAuthModule.registerWithEmail(
            teacherMap["email"], teacherMap["password"])) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      TeacherModel teacher = TeacherModel(
          id: id,
          name: teacherMap["name"],
          email: teacherMap["email"],
          birthday: teacherMap["birthday"],
          ssn: teacherMap["ssn"],
          address: teacherMap["address"],
          homePhone: teacherMap["homePhone"],
          phone: teacherMap["phone"],
          classIDs: teacherMap["classIDs"],
          weeklyLessonHours: teacherMap["weeklyLessonHours"]);
      await _firebaseStorage
          .collection("teachers")
          .doc(id)
          .set(teacher.toMap());
      return true;
    }
    return false;
  }

  static Future<bool> createStudent(Map studentMap) async {
    bool isExists = (await _firebaseStorage
            .collection("students")
            .where("email", isEqualTo: studentMap["email"])
            .get())
        .docs
        .isNotEmpty;
    if (!isExists &&
        await FirebaseAuthModule.registerWithEmail(
            studentMap["email"], studentMap["password"])) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      StudentModel student = StudentModel(
          id: id,
          name: studentMap["name"],
          email: studentMap["email"],
          birthday: studentMap["birthday"],
          ssn: studentMap["ssn"],
          address: studentMap["address"],
          classID: studentMap["classID"],
          bookNumber: studentMap["bookNumber"]);
      await _firebaseStorage
          .collection("students")
          .doc(id)
          .set(student.toMap());
      return true;
    }
    return false;
  }

  static setUser({bool asTeacher = false}) async {
    User user = FirebaseAuth.instance.currentUser!;
    String id = user.uid;
    CollectionReference collectionReference;
    DocumentSnapshot document;
    if (asTeacher) {
      collectionReference = _firebaseStorage.collection("teachers");
      document = await collectionReference.doc(id).get();
      DateTime birthday = DateTime.fromMicrosecondsSinceEpoch(
          (document["birthday"] as Timestamp).microsecondsSinceEpoch);
      TeacherModel teacher = TeacherModel(
          id: id,
          name: document["name"],
          email: document["email"],
          birthday: birthday,
          ssn: document["ssn"],
          address: document["address"],
          homePhone: document["homePhone"],
          phone: document["phone"],
          classIDs: document["classIDs"],
          weeklyLessonHours: document["weeklyLessonHours"]);
      teacher.calculateStudents();
      _userProvider.user = teacher;
    } else {
      collectionReference = _firebaseStorage.collection("students");
      document = await collectionReference.doc(id).get();
      DateTime birthday = DateTime.fromMicrosecondsSinceEpoch(
          (document["birthday"] as Timestamp).microsecondsSinceEpoch);
      StudentModel student = StudentModel(
          id: id,
          name: document["name"],
          email: document["email"],
          birthday: birthday,
          ssn: document["ssn"],
          address: document["address"],
          classID: document["classID"],
          bookNumber: document["bookNumber"]);
      student.setTeacher();
      _userProvider.user = student;
    }
  }

  static Future<List<StudentModel>> listStudents(TeacherModel teacher) async {
    List<QueryDocumentSnapshot> documents = (await _firebaseStorage
            .collection("students")
            .where("classID", whereIn: teacher.classIDs)
            .get())
        .docs;
    List<StudentModel> students = [];
    documents.forEach((element) {
      students.add(StudentModel(
        id: element.id,
        name: element["name"],
        email: element["email"],
        birthday: DateTime.now(),
        ssn: element["ssn"],
        address: element["address"],
        classID: element["classID"],
        bookNumber: element["bookNumber"],
      ));
    });
    return students;
  }

  static Future<TeacherModel> getTeacher(StudentModel student) async {
    QueryDocumentSnapshot document = (await _firebaseStorage
            .collection("teachers")
            .where("classIDs", arrayContains: student.classID)
            .get())
        .docs
        .first;
    TeacherModel teacher = TeacherModel(
      id: document.id,
      name: document["name"],
      email: document["email"],
      birthday: DateTime.now(),
      ssn: document["ssn"],
      address: document["address"],
      homePhone: document["homePhone"],
      phone: document["phone"],
      classIDs: document["classIDs"],
      weeklyLessonHours: document["weeklyLessonHours"],
    );
    teacher.calculateStudents();
    return teacher;
  }
}
