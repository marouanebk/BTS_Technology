import 'package:bts_technologie/core/network/api_constants.dart';
import 'package:bts_technologie/finances/data/model/cashflow_model.dart';
import 'package:bts_technologie/finances/data/model/finance_model.dart';
import 'package:dio/dio.dart';
import 'package:bts_technologie/core/error/exceptions.dart';
import 'package:bts_technologie/core/network/error_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseFinanceRemoteDateSource {
  Future<List<FinanceModel>> getFinances();
  Future<CashFlowModel> getCashFlow();
  
}

class FinanceRemoteDataSource extends BaseFinanceRemoteDateSource {
  @override
  Future<List<FinanceModel>> getFinances() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getFinancesApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return FinanceModel.fromJsonList(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['err']));
    }
  }
  
  @override
  Future<CashFlowModel> getCashFlow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final response = await Dio().get(ApiConstance.getCashFlowApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ));
    if (response.statusCode == 200) {
      return CashFlowModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: response.statusCode,
              statusMessage: response.data['err']));
    }
  }
}
