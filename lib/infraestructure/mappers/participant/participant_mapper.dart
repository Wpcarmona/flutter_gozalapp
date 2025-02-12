import 'package:gozalapp/domain/entities/entities.dart';
import 'package:gozalapp/infraestructure/models/models.dart';

class ParticipantMapper {
  static User participantToEntity(ParticipantResponse participant) => User(
    ok: participant.ok,
    user: ObjectUser(
      uid: participant.object.uid,
      uidType: participant.object.uidType,
      email: participant.object.email,
      points: participant.object.points,
      totalPoints: participant.object.totalPoints,
      coins: participant.object.coins.map((e) => e.toString()).toList(),
      totalCoins: participant.object.totalCoins.map((e) => e.toString()).toList(),
      state: participant.object.state,
      badEmail: participant.object.badEmail,
      emailVerified: participant.object.emailVerified,
      cellphoneVerified: participant.object.cellphoneVerified,
      unconfirmedEmail: participant.object.unconfirmedEmail,
      unconfirmedCellphone: participant.object.unconfirmedCellphone,
      avatar: participant.object.avatar,
      lastActivityAt: participant.object.lastActivityAt,
      nombreCompleto: participant.object.nombreCompleto,
      numeroDeCelular: PhoneNumber(
        ccode: participant.object.numeroDeCelular.ccode,
        number: participant.object.numeroDeCelular.number,
      ),
      tipoDeDocumento: participant.object.tipoDeDocumento,
      numeroDeDocumento: participant.object.numeroDeDocumento,
      tags: participant.object.tags.map((e) => e.toString()).toList(),
      aceptarTerminos: participant.object.aceptarTerminos,
    ),
  );
}
