import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/signInPages/signInCheckPage.dart';
import 'package:kedu/ui/pages/signUpPages/signUpCompleteParentPage.dart';
import 'package:kedu/ui/pages/signUpPages/signUpParentPage.dart';
import 'package:kedu/ui/pages/signUpPages/signUpTeacherPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: _body(),
      ),
    );
  }

  Widget _body(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Eğer KEDU'da \nyeniysen",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0XFF646464)),),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(32),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color(0XFF987B89),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hemen Kaydol",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpTeacherPage(),)),
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            elevation: 6,
                            child: Container(
                              width: MediaQuery.of(context).size.width/4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("Öğretmen",style: TextStyle(color: Colors.white))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpParentPage(),)),
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            elevation: 6,
                            child: Container(
                              width: MediaQuery.of(context).size.width/4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.green,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("Veli",style: TextStyle(color: Colors.white),)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Text("Ya da",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0XFF646464)),),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(32),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Color(0XFFE4DD3D),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Zaten Kayıtlıysan",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInCheckPage(),
                              )),
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                            child: Center(
                              child: Text(
                                "Giriş Yap",
                                style: TextStyle(fontSize: 18),
                              ),
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
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }

}
