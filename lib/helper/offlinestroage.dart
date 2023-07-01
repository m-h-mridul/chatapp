import 'package:shared_preferences/shared_preferences.dart';

class OfflineStrogae {
  static OfflineStrogae? _instance;
  OfflineStrogae._();
  static OfflineStrogae get instance {
    _instance ??= OfflineStrogae._();
    return _instance!;
  }

  late SharedPreferences _prefs;
  readyDatabase() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void insertData({String? name, String? value}) async {
    await _prefs.setString(name!, value!);
  }

  bool cheakdata({String? name}) {
    return _prefs.getBool(name!) ?? false;
  }

  String getdata({String? name}) {
    return _prefs.getString(name!) ?? "not find";
  }

  void removeData({String? name}) {
    _prefs.remove(name!);
  }
}
