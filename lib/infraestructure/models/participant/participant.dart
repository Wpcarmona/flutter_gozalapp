import 'package:meta/meta.dart';
import 'dart:convert';

ParticipantResponse participantResponseFromJson(String str) => ParticipantResponse.fromJson(json.decode(str));

String participantResponseToJson(ParticipantResponse data) => json.encode(data.toJson());

class ParticipantResponse {
    String ok;
    Object object;

    ParticipantResponse({
        required this.ok,
        required this.object,
    });

    factory ParticipantResponse.fromJson(Map<String, dynamic> json) => ParticipantResponse(
        ok: json["ok"],
        object: Object.fromJson(json["object"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "object": object.toJson(),
    };
}

class Object {
    String uid;
    String uidType;
    String email;
    int points;
    int totalPoints;
    List<dynamic> coins;
    List<dynamic> totalCoins;
    String state;
    bool badEmail;
    bool emailVerified;
    bool cellphoneVerified;
    bool unconfirmedEmail;
    bool unconfirmedCellphone;
    String avatar;
    DateTime lastActivityAt;
    String nombreCompleto;
    NumeroDeCelular numeroDeCelular;
    String tipoDeDocumento;
    String numeroDeDocumento;
    dynamic tags;
    dynamic aceptarTerminos;

    Object({
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
        required this.aceptarTerminos,
    });

    factory Object.fromJson(Map<String, dynamic> json) => Object(
        uid: json["uid"],
        uidType: json["uid_type"],
        email: json["email"],
        points: json["points"],
        totalPoints: json["total_points"],
        coins: List<dynamic>.from(json["coins"].map((x) => x)),
        totalCoins: List<dynamic>.from(json["total_coins"].map((x) => x)),
        state: json["state"],
        badEmail: json["bad_email"],
        emailVerified: json["email_verified"],
        cellphoneVerified: json["cellphone_verified"],
        unconfirmedEmail: json["unconfirmed_email"],
        unconfirmedCellphone: json["unconfirmed_cellphone"],
        avatar: json["avatar"],
        lastActivityAt: DateTime.parse(json["last_activity_at"]),
        nombreCompleto: json["nombre_completo"],
        numeroDeCelular: NumeroDeCelular.fromJson(json["numero_de_celular"]),
        tipoDeDocumento: json["tipo_de_documento"],
        numeroDeDocumento: json["numero_de_documento"],
        tags: json["tags"],
        aceptarTerminos: json["aceptar_terminos"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "uid_type": uidType,
        "email": email,
        "points": points,
        "total_points": totalPoints,
        "coins": List<dynamic>.from(coins.map((x) => x)),
        "total_coins": List<dynamic>.from(totalCoins.map((x) => x)),
        "state": state,
        "bad_email": badEmail,
        "email_verified": emailVerified,
        "cellphone_verified": cellphoneVerified,
        "unconfirmed_email": unconfirmedEmail,
        "unconfirmed_cellphone": unconfirmedCellphone,
        "avatar": avatar,
        "last_activity_at": lastActivityAt.toIso8601String(),
        "nombre_completo": nombreCompleto,
        "numero_de_celular": numeroDeCelular.toJson(),
        "tipo_de_documento": tipoDeDocumento,
        "numero_de_documento": numeroDeDocumento,
        "tags": tags,
        "aceptar_terminos": aceptarTerminos,
    };
}

class NumeroDeCelular {
    String ccode;
    String number;

    NumeroDeCelular({
        required this.ccode,
        required this.number,
    });

    factory NumeroDeCelular.fromJson(Map<String, dynamic> json) => NumeroDeCelular(
        ccode: json["ccode"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "ccode": ccode,
        "number": number,
    };
}
