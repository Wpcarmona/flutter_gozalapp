

import 'package:gozalapp/domain/entities/entities.dart';

abstract class ReferralsRepository {
  Future<Referrals> getReferrals();
}