


import 'package:gozalapp/domain/datasources/domain_datasource.dart';
import 'package:gozalapp/domain/entities/referrals/referrals.dart';
import 'package:gozalapp/domain/repositories/referrals_repository/referrals_repository.dart';

class ReferralsRepositoryImpl extends ReferralsRepository {

  final ReferralsDatasource referralsDatasource;

  ReferralsRepositoryImpl({required this.referralsDatasource});
  @override
  Future<Referrals> getReferrals() {
    return referralsDatasource.getReferrals();
  }
  
}