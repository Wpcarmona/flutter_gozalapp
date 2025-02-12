
class User {
  final String ok;
  final ObjectUser user;

  User({
    required this.ok,
    required this.user,
  });
}

class ObjectUser {
  final String uid;
  final String uidType;
  final String email;
  final int points;
  final int totalPoints;
  final List<String> coins;
  final List<String> totalCoins;
  final String state;
  final bool badEmail;
  final bool emailVerified;
  final bool cellphoneVerified;
  final bool unconfirmedEmail;
  final bool unconfirmedCellphone;
  final String avatar;
  final DateTime lastActivityAt;
  final String nombreCompleto;
  final PhoneNumber numeroDeCelular;
  final String tipoDeDocumento;
  final String numeroDeDocumento;
  final List<String> tags;
  final bool? aceptarTerminos;

  ObjectUser({
    required this.uid,
    required this.uidType,
    required this.email,
    required this.points,
    required this.totalPoints,
    required this.coins,
    required this.totalCoins,
    required this.state,
    required this.badEmail,
    required this.emailVerified,
    required this.cellphoneVerified,
    required this.unconfirmedEmail,
    required this.unconfirmedCellphone,
    required this.avatar,
    required this.lastActivityAt,
    required this.nombreCompleto,
    required this.numeroDeCelular,
    required this.tipoDeDocumento,
    required this.numeroDeDocumento,
    required this.tags,
    this.aceptarTerminos,
  });
}

class PhoneNumber {
  final String ccode;
  final String number;

  PhoneNumber({required this.ccode, required this.number});
}
