import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/login_response_entity.dart';

class SharedPreferenceServices {
static late SharedPreferences sharedPreferences;
static Future<void> init()async{
  sharedPreferences = await SharedPreferences.getInstance();
}
static Future<bool> saveData(String key ,dynamic value){
  if(value is int){
    return sharedPreferences.setInt(key, value);
  }
  else if(value is double){
    return sharedPreferences.setDouble(key, value);
  }
 else if(value is String){
    return sharedPreferences.setString(key, value);
  }
 else{
    return sharedPreferences.setBool(key, value);
  }
}
static Object? getData(String key){
  return sharedPreferences.get(key);
}
static Future<bool> deleteData(String key)async{
  return await sharedPreferences.remove(key);
}
}

class Prefs {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save user data in SharedPreferences
  static Future<void> saveUserData(UserLoginResponseEntity user) async {
    await _preferences?.setString('user_id', user.id ?? "");
    await _preferences?.setString('username', user.username ?? "");
    await _preferences?.setString('first_name', user.firstName ?? "");
    await _preferences?.setString('last_name', user.lastName ?? "");
    await _preferences?.setString('email', user.email ?? "");
    await _preferences?.setString('phone', user.phone ?? "");
    await _preferences?.setBool('is_verified', user.isVerified ?? false);
  }

  /// Retrieve user data from SharedPreferences
  static UserLoginResponseEntity? getUserData() {
    String? id = _preferences?.getString('user_id');
    String? username = _preferences?.getString('username');
    String? firstName = _preferences?.getString('first_name');
    String? lastName = _preferences?.getString('last_name');
    String? email = _preferences?.getString('email');
    String? phone = _preferences?.getString('phone');
    bool? isVerified = _preferences?.getBool('is_verified') ?? false;

    if (id == null || id.isEmpty) {
      return null; // Return null if user is not found
    }

    return UserLoginResponseEntity(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      isVerified: isVerified,
    );
  }

  /// Logout user (clear stored data)
  static Future<void> logoutUser() async {
    await _preferences?.clear();
  }
}
