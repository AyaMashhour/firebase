import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static  SharedPreferences sharedPreferences;

  static init()async
  {
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static  String getData({
    String key,

  })
  {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    String key,
   String value,
  }) async
  {
    return await sharedPreferences.setString(key,value);
  }


}