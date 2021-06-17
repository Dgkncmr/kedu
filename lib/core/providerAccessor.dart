import 'package:kedu/core/providers/chatProvider.dart';
import 'package:kedu/core/providers/userProvider.dart';

class ProviderAccessor {
  static final ProviderAccessor instance = ProviderAccessor._constructor();

  ProviderAccessor._constructor();

  UserProvider? _userProvider;
  ChatProvider? _chatProvider;

  register(
      {required UserProvider userProvider,
      required ChatProvider chatProvider}) {
    this._userProvider = userProvider;
    this._chatProvider = chatProvider;
  }

  ChatProvider get chat => _chatProvider!;

  UserProvider get user => _userProvider!;
}
