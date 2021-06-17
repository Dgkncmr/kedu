import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kedu/core/models/messageModel.dart';
import 'package:kedu/core/modules/firestoreModule.dart';
import 'package:kedu/core/providers/chatProvider.dart';
import 'package:kedu/core/providers/userProvider.dart';
import 'package:kedu/core/providerAccessor.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProviderRegister extends StatelessWidget {
  late UserProvider _userProvider;
  late ChatProvider _chatProvider;
  Widget _child;
  bool _asTeacher;

  ProviderRegister(this._child, {bool asTeacher = false})
      : _asTeacher = asTeacher;

  Future _load() async {
    _userProvider = UserProvider();
    _chatProvider = ChatProvider();
    await ProviderAccessor.instance
        .register(userProvider: _userProvider, chatProvider: _chatProvider);
    await FireStoreModule.setUser(asTeacher: _asTeacher);
    await _userProvider.getUsers();
    await _chatProvider.load();
    await _chatProvider.getChats();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => _userProvider,
              ),
              ChangeNotifierProvider(
                create: (context) => _chatProvider,
              ),
            ],
            child: MaterialApp(
              home: this._child,
              debugShowCheckedModeBanner: false,
            ),
          );
        } else {
          return Scaffold(body: Center());
        }
      },
    );
  }
}
