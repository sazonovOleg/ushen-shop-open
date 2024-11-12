import 'package:TeaShopApp/src/features/tea/domain/models/all_tea_hive_model.dart';
import 'package:TeaShopApp/src/infrastructure/hive/hive_storage.dart';
import 'package:TeaShopApp/src/infrastructure/shared_pref/shared_pref.dart';

class TeaDataStorage {
  final HiveStorage _hiveStorage;
  final SharedPref _sharedPref;

  TeaDataStorage(
    this._hiveStorage,
    this._sharedPref,
  );

  final String _allTeaKey = 'allTeaHiveKey';
  final String _categoryTeaKey = 'categoryTeaKey';
  final String _subCategoryTeaKey = 'subCategoryTeaKey';

  Future<void> saveAllTeaList(List<AllTeaModel> allTeaList) async {
    await _hiveStorage.saveBox(_allTeaKey, allTeaList);
  }

  Future<List<AllTeaModel>> getAllTeaList() async {
    final teaList = await _hiveStorage.getBox(_allTeaKey);

    return teaList.cast<AllTeaModel>();
  }

  Future<void> saveCategoryTeaList(List<AllTeaModel> categoryTeaList) async {
    await _hiveStorage.saveBox(_categoryTeaKey, categoryTeaList);
  }

  Future<List<AllTeaModel>> getCategoryTeaList() async {
    final categoryList = await _hiveStorage.getBox(_categoryTeaKey);

    return categoryList.cast<AllTeaModel>();
  }

  Future<void> saveSubCategoryTeaList(List<TeaModel> teaList) async {
    await _hiveStorage.saveBox(_subCategoryTeaKey, teaList);
  }

  Future<List<TeaModel>> getSubCategoryTeaList() async {
    final list = await _hiveStorage.getBox(_subCategoryTeaKey);
    final List<TeaModel> teaList = [];

    return list ?? teaList;
  }

  Future<void> clearSubCategoryTeaList() async {
    await _hiveStorage.clearBox(_subCategoryTeaKey);
  }
}
