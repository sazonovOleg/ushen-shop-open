import 'package:TeaShopApp/src/features/tea/data/tea_repo.dart';
import 'package:TeaShopApp/src/features/tea/domain/models/all_tea_hive_model.dart';

class TeaService {
  final TeaRepo _repo;

  TeaService(
    this._repo,
  );

  Future<void> initAllTypeOfTea() async {
    await _repo.saveAllTeaList();
  }

  Future<List<AllTeaModel>> getAllTypeOfTea() async {
    final storageList = await _repo.getAllTea();

    return storageList;
  }

  Future<void> initSortTypeOfTea(String type, String subtype) async {
    subtype.isNotEmpty
        ? await _repo.saveSubCategoryTeaList(type, subtype)
        : await _repo.saveCategoryTeaList(type);
  }

  Future<List<AllTeaModel>> getCategoryTeaList() async {
    final storageList = await _repo.getCategoryTeaList();

    return storageList;
  }

  Future<List<TeaModel>> getSubCategoryTeaList() async {
    final storageList = await _repo.getSubCategoryTeaList();

    return storageList;
  }

  Future<void> clearSubCategoryTeaList() async {
    await _repo.clearSubCategoryTeaList();
  }
}
