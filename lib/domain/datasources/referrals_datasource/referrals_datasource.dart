

import 'package:gozalapp/domain/entities/entities.dart';

abstract class ReferralsDatasource {

  Future<Referrals> getReferrals();
}