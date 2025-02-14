

import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class ReferralsMapper {

  static Referrals referralsToEntity(ReferralsResponse referrals)=> Referrals(
    ok: referrals.ok,
    code: referrals.code
  );
}