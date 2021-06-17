import 'package:flutter/material.dart';
import 'package:kedu/ui/assets/Assets.dart';
import 'package:kedu/ui/assets/Colors.dart';

class UploadHomeworkPageParent extends StatefulWidget {
  const UploadHomeworkPageParent({Key? key}) : super(key: key);

  @override
  _UploadHomeworkPageParentState createState() => _UploadHomeworkPageParentState();
}

class _UploadHomeworkPageParentState extends State<UploadHomeworkPageParent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: _body(),
        bottomNavigationBar: Assets.navBarParent(context),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(32),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios)),
                        Text(
                          "Soru Çözme",
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
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("İsim Soyisim: "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Sınıf/Şube:  "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Ders İsmi: "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Ödev Tarihi: "),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Muhammed Yılmaz"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("2/A"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Matematik"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("01.01.2021"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Dosya Yükleme Modülü"),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0XFFFFEAB9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_copy_outlined),
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Dosya Seç",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text("Ödev için dosya seçiniz")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Öğretmenine Not Bırak"),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0XFFF8F9FA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 0.2, color: Colors.black54),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          hintText: "Bir not bırakın",
                          border: InputBorder.none,
                        ),
                        minLines: 5,
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Color(0XFFFFAB5D),
                          elevation: 0,
                          onPressed: () {},
                          child: Icon(Icons.upload_file_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
