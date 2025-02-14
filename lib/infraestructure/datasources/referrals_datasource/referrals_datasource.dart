


import 'package:dio/dio.dart';
import 'package:gozalapp/config/constants/environment.dart';
import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/referrals/referrals.dart';
import 'package:gozalapp/infraestructure/mappers/mappers.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class ReferralsSPDataSource extends ReferralsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: Environment.baseUrl,
  ));

  Referrals _jsonToReferrals(Map<String, dynamic> json){
    final referralsResponse = ReferralsResponse.fromJson(json);
    return ReferralsMapper.referralsToEntity(referralsResponse);
  }

  @override
  Future<Referrals> getReferrals() async {
    final response = await dio.post(
      '/referrals',
      options: Options(
        headers: {
          'Authorization': 'Bearer 123', //TODO agregar el header desde el isar
        }
      )
    );
    return _jsonToReferrals(response.data);
  }
  
}