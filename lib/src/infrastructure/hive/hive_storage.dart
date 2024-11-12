import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  Future<void> saveBox(
    String boxName,
    dynamic value,
  ) async {
    final box = await Hive.openBox(boxName);
    await box.put(boxName, value);
  }

  Future<dynamic> getBox(String boxName) async {
    final box = await Hive.openBox(boxName);

    if (box.isEmpty) {
      return null;
    } else {
      return box.get(boxName);
    }
  }

  Future<void> clearBox(String boxName) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
