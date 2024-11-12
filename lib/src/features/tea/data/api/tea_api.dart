import 'package:TeaShopApp/src/features/tea/data/api/tea_api_constants.dart';
import 'package:TeaShopApp/src/features/tea/data/models/all_tea_model_response.dart';
import 'package:TeaShopApp/src/features/tea/data/models/tea_model_response.dart';
import 'package:dio/dio.dart';

class TeaApi {
  final Dio _dio;

  TeaApi(this._dio);

  Future<List<AllTeaModelResponse>> getAllTea() async {
    final response = await _dio.get(
      TeaApiConstants.allTea,
    );

    return allTeaResponseFromJson(response.data);
  }

  Future<List<AllTeaModelResponse>> getCategoryTea(
    String type,
  ) async {
    final response = await _dio.post(
      TeaApiConstants.teaCategory,
      data: {'type': type},
    );

    return allTeaResponseFromJson(response.data);
  }

  Future<List<TeaModelResponse>> getTeaByType(
    String type,
    String subtype,
  ) async {
    final response = await _dio.post(
      TeaApiConstants.teaApi,
      data: {
        'type': type,
        'subtype': subtype,
      },
    );

    return teaResponseFromJson(response.data);
  }
}
