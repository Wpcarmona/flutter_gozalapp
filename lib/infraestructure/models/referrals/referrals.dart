import 'package:meta/meta.dart';
import 'dart:convert';

ReferralsResponse referralsResponseFromJson(String str) => ReferralsResponse.fromJson(json.decode(str));

String referralsResponseToJson(ReferralsResponse data) => json.encode(data.toJson());

class ReferralsResponse {
    String ok;
    String code;

    ReferralsResponse({
        required this.ok,
        required this.code,
    });

    factory ReferralsResponse.fromJson(Map<String, dynamic> json) => ReferralsResponse(
        ok: json["ok"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "code": code,
    };
}
