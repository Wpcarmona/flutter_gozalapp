import 'dart:convert';

UpdateUserResponse updateUserResponseFromJson(String str) => UpdateUserResponse.fromJson(json.decode(str));

String updateUserResponseToJson(UpdateUserResponse data) => json.encode(data.toJson());

class UpdateUserResponse {
    String ok;
    String message;

    UpdateUserResponse({
        required this.ok,
        required this.message,
    });

    factory UpdateUserResponse.fromJson(Map<String, dynamic> json) => UpdateUserResponse(
        ok: json["ok"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
    };
}
