

import 'package:aynachatx/core/entities/user.dart';
import 'package:aynachatx/core/errors/failures.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDataSource{
  Future<UserCreationResult> createUser({ @required User user });
  Future<String?> loginUser({@required User user});
  Future<User> checkUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{

  late Box<User> _users;
  Future<void> init() async{
    Hive.registerAdapter(UserAdapter());
    _users= await Hive.openBox<User>("userBox");
  }
  Future<String?> authenticateUser(final String username, final String password) async {
    final success = await _users.values.any((element) => element.name == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  var _currentUser = User( name: "", password:"");
  @override
  Future<UserCreationResult> createUser({User? user}) async {
    final alreadyExists = _users.values.any(
          (element) => element.name.toLowerCase() == user!.name.toLowerCase(),
    );

    if (alreadyExists) {
      return UserCreationResult.already_exists;
    }

    try {
      _users.add(User(name: user!.name,password:user.password));
      return UserCreationResult.success;
    } on Exception catch (ex) {
      return UserCreationResult.failure;
    }
   /*try{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString('username', user!.name);
     await prefs.setString('password', user!.password);
     return user;
   }on Exception catch(e){
     throw Exception(e);
   }*/
  }
  @override
  Future<User> checkUser() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? '';
      String password = prefs.getString('password') ?? '';
      _currentUser= User( name: username,password: password);
      return _currentUser;
    }on Exception catch(e){
      throw Exception(e);
    }

  }

  @override
  Future<String?> loginUser({User? user}) async {
    final success = await _users.values.any((element) => element.name.toLowerCase()  == user?.name && element.password == user?.password);
    if (success) {
      _currentUser= User( name: user!.name,password: user!.password);
      return user!.name;
    } else {
      return null;
    }
    /*if (_currentUser.name=="") {
      throw  Failure('User is null!');
    }
    if(_currentUser.password == user?.password){
      return user!!;
    }else{
      throw Failure("Invalid User or password");
    }*/

  }


}
enum UserCreationResult { success, failure, already_exists }