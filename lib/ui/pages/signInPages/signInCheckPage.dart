import 'package:flutter/material.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/signInPages/signInParentPage.dart';
import 'package:kedu/ui/pages/signInPages/signInTeacherPage.dart';

class SignInCheckPage extends StatefulWidget {
  const SignInCheckPage({Key? key}) : super(key: key);

  @override
  _SignInCheckPageState createState() => _SignInCheckPageState();
}

class _SignInCheckPageState extends State<SignInCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/teacherImage.png",
                  scale: 2,
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInTeacherPage(),
                      )),
                  child: Material(
                    borderRadius: BorderRadius.circular(32),
                    elevation: 6,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Center(
                            child: Text(
                          "Öğretmen",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/parentImage.png",
                  scale: 2,
                ),
                SizedBox(
                  height: 8.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInParentPage(),
                      )),
                  child: Material(
                    borderRadius: BorderRadius.circular(32),
                    elevation: 6,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: Center(
                            child: Text(
                          "Veli",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
