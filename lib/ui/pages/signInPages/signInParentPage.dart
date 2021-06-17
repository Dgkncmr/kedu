import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kedu/core/modules/firebaseAuthModule.dart';
import 'package:kedu/core/providerRegisterer.dart';
import 'package:kedu/ui/assets/Colors.dart';
import 'package:kedu/ui/pages/parentPages/homePageParent.dart';
import 'package:kedu/ui/pages/signUpPages/signUpPage.dart';

class SignInParentPage extends StatefulWidget {
  const SignInParentPage({Key? key}) : super(key: key);

  @override
  _SignInParentPageState createState() => _SignInParentPageState();
}

class _SignInParentPageState extends State<SignInParentPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            "assets/images/keduLogo.png",
            scale: 4,
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
                            child: Text("E-Posta Adresi"),
                          ),
                        ],
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(32),
                        elevation: 6,
                        child: TextField(
                          controller: emailController,
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
                          controller: passwordController,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                            hintText: "*******",
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
          SizedBox(
            height: 64,
          ),
          GestureDetector(
            onTap: () async {
              if (await FirebaseAuthModule.loginWithEmail(
                  emailController.text, passwordController.text)) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProviderRegister(
                        HomePageParent(),
                      ),
                    ));
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Center(
                child: Text(
                  "Giriş Yap",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0XFFF1CA72),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          Spacer(),
          InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  )),
              child: Text("Hesabın yok mu? Lütfen Kaydol")),
        ],
      ),
    );
  }
}
