import 'package:flutter/material.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/signUpPages/signUpCompleteParentPage.dart';

class SignUpEmailPswParentPage extends StatefulWidget {
  Map _data;

  SignUpEmailPswParentPage(this._data, {Key? key}) : super(key: key);

  @override
  _SignUpEmailPswParentPageState createState() =>
      _SignUpEmailPswParentPageState();
}

class _SignUpEmailPswParentPageState extends State<SignUpEmailPswParentPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("E-Posta Adresi"),
                          ),
                        ],
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        elevation: 6,
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            hintText: "example@hotmail.com",
                            hintStyle: TextStyle(color: Colors.black38),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Şifre"),
                          ),
                        ],
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        elevation: 6,
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            hintText: "******",
                            hintStyle: TextStyle(color: Colors.black38),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Şifre Tekrarı"),
                          ),
                        ],
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        elevation: 6,
                        child: TextField(
                          obscureText: true,
                          controller: rePassword,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            hintText: "******",
                            hintStyle: TextStyle(color: Colors.black38),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1),
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    var snackBar;
                    if (password.text == rePassword.text) {
                      Map data = widget._data;
                      data["email"] = email.text;
                      data["password"] = password.text;
                      if (await FireStoreModule.createStudent(data)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpCompleteParentPage(),
                          ),
                        );
                      }
                      snackBar = SnackBar(
                          content: Text(
                              'Kayıt başarısız! Email ve şifreyi kontrol edin.'));
                    } else {
                      snackBar = SnackBar(
                          content:
                              Text('Kayıt başarısız! Şifreler uyuşmuyor.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          "Kayıt Ol",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Image.asset(
                "assets/images/book.png",
                scale: 2,
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
