import 'package:TeaShopApp/src/features/tea/data/tea_data_storage.dart';
import 'package:TeaShopApp/src/features/tea/domain/models/all_tea_hive_model.dart';

import 'api/tea_api.dart';

class TeaRepo {
  final TeaApi _api;
  final TeaDataStorage _storage;

  TeaRepo(
    this._api,
    this._storage,
  );

  Future<void> saveAllTeaList() async {
    final response = await _api.getAllTea();

    final list = response
        .map(
          (e) => AllTeaModel(
            id: e.id,
            name: e.name,
            img: e.img,
            type: e.type,
            subtype: '',
          ),
        )
        .toList();

    if (list.isNotEmpty) {
      await _storage.saveAllTeaList(list);
    }
  }

  Future<void> saveCategoryTeaList(String type) async {
    final response = await _api.getCategoryTea(type);

    if (response.isNotEmpty) {
      final list = response
          .map(
            (e) => AllTeaModel(
              id: e.id,
              name: e.name,
              img: e.img,
              type: e.type,
              subtype: e.subtype!,
            ),
          )
          .toList();

      await _storage.saveCategoryTeaList(list);
    } else {
      final response = await _api.getTeaByType(type, type);

      final list = response
          .map(
            (e) => TeaModel(
              id: e.id,
              name: e.name,
              price: e.price,
              fullPrice: e.fullPrice,
              weight: e.weight,
              description: e.description,
              type: e.type,
              subtype: e.subtype,
              quantity: e.quantity,
              saleQuantity: e.saleQuantity,
              full: e.full,
              images: e.images,
            ),
          )
          .toList();

      await _storage.saveSubCategoryTeaList(list);
    }
  }

  Future<void> saveSubCategoryTeaList(String type, String subtype) async {
    final response = await _api.getTeaByType(type, subtype);

    final list = response
        .map(
          (e) => TeaModel(
            id: e.id,
            name: e.name,
            price: e.price,
            fullPrice: e.fullPrice,
            weight: e.weight,
            description: e.description,
            type: e.type,
            subtype: e.subtype,
            quantity: e.quantity,
            saleQuantity: e.saleQuantity,
            full: e.full,
            images: e.images,
          ),
        )
        .toList();

    await _storage.saveSubCategoryTeaList(list);
  }

  Future<List<AllTeaModel>> getAllTea() async {
    final list = await _storage.getAllTeaList();

    return list;
  }

  Future<List<AllTeaModel>> getCategoryTeaList() async {
    final list = await _storage.getCategoryTeaList();

    return list;
  }

  Future<List<TeaModel>> getSubCategoryTeaList() async {
    final list = await _storage.getSubCategoryTeaList();

    return list;
  }

  Future<void> clearSubCategoryTeaList() async {
    await _storage.clearSubCategoryTeaList();
  }
}
