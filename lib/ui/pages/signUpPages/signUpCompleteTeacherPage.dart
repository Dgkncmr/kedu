import 'package:flutter/material.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/signInPages/signInParentPage.dart';
import 'package:kedu/ui/pages/signInPages/signInTeacherPage.dart';

class SignUpCompleteTeacherPage extends StatefulWidget {
  const SignUpCompleteTeacherPage({Key? key}) : super(key: key);

  @override
  _SignUpCompleteTeacherPageState createState() => _SignUpCompleteTeacherPageState();
}

class _SignUpCompleteTeacherPageState extends State<SignUpCompleteTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        centerTitle: true,
        backgroundColor: AppColors.secondAppBarColor,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Kaydınız Başarıyla Tamamlandı",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 8.0,),
                  Text("Lütfen Giriş Yapınız",style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInTeacherPage(),
                      )),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Row(
                      children: [
                        Text(
                          "Giriş Yap",
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
          Image.asset("assets/images/completeImage2.png",scale: 2,),
        ],
      ),
    );
  }
}
