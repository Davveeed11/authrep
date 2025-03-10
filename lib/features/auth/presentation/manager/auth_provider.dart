import 'package:baka/features/auth/domain/auth_repo.dart';
import 'package:baka/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final state = AuthState();
  final repo = AuthRepo;

  setEmail(String email) {
    //used to set the email variable
    state.email = email;
    notifyListeners();
  }

  setPassword(String password) {
    //used to set the password
    state.password = password;
    notifyListeners();
  }

  login() async {
    state.isLoading = true;
    notifyListeners();
    //repo.login(.....,.....)
    //repo.login.....
    /*for(var i = 0; i < 5; i++){
      await Future.delayed(const Duration(seconds: 1));
      print(i);
    }*/
    print('pre-delay');
    await Future.delayed(Duration(seconds: 3));
    print('post-delay');

    /*EXAMPLE OF REPO CALL FROM YOUR PROVIDER
    * repo.login().then(value){
    *
    * final result = value.getOrElse((error){
    * //do something with the error
    * state.isLoading = false;
    * notifyListeners();
    * });
    *
    * if(result != null){
    * //do something with the result as it is not equal to null
    * state.isLoading = false;
    * notifyListeners();
    * }
    *
    * })
    * */

    //this will happen in the body of the repo call, when it returns a
    //successful result or a failure result
    state.isLoading = false;
    notifyListeners();
  }
}
