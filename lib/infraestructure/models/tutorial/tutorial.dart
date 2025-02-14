import 'package:meta/meta.dart';
import 'dart:convert';

TutorialStatusResponse tutorialStatusResponseFromJson(String str) => TutorialStatusResponse.fromJson(json.decode(str));

String tutorialStatusResponseToJson(TutorialStatusResponse data) => json.encode(data.toJson());

class TutorialStatusResponse {
    String id;
    String name;
    bool status;

    TutorialStatusResponse({
        required this.id,
        required this.name,
        required this.status,
    });

    factory TutorialStatusResponse.fromJson(Map<String, dynamic> json) => TutorialStatusResponse(
        id: json["id"],
        name: json["name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
    };
}
