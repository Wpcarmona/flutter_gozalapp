import 'package:meta/meta.dart';
import 'dart:convert';

CreateCommentResponse createCommentResponseFromJson(String str) => CreateCommentResponse.fromJson(json.decode(str));

String createCommentResponseToJson(CreateCommentResponse data) => json.encode(data.toJson());

class CreateCommentResponse {
    String ok;
    String activityState;
    int activityPoints;
    String message;
    String executionError;
    CommentObject object;

    CreateCommentResponse({
        required this.ok,
        required this.activityState,
        required this.activityPoints,
        required this.message,
        required this.executionError,
        required this.object,
    });

    factory CreateCommentResponse.fromJson(Map<String, dynamic> json) => CreateCommentResponse(
        ok: json["ok"],
        activityState: json["activity_state"],
        activityPoints: json["activity_points"],
        message: json["message"],
        executionError: json["execution_error"],
        object: CommentObject.fromJson(json["object"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "activity_state": activityState,
        "activity_points": activityPoints,
        "message": message,
        "execution_error": executionError,
        "object": object.toJson(),
    };
}

class CommentObject {
    String id;
    String type;
    int activityCount;
    String atype;
    dynamic category;
    String moderation;
    int points;
    String state;
    int createdAt;
    int executeDate;
    String module;
    String name;
    dynamic team;
    Participant participant;
    int votesCount;
    List<dynamic> tags;
    List<dynamic> participantsTags;
    dynamic pushRedirectUrl;

    CommentObject({
        required this.id,
        required this.type,
        required this.activityCount,
        required this.atype,
        required this.category,
        required this.moderation,
        required this.points,
        required this.state,
        required this.createdAt,
        required this.executeDate,
        required this.module,
        required this.name,
        required this.team,
        required this.participant,
        required this.votesCount,
        required this.tags,
        required this.participantsTags,
        required this.pushRedirectUrl,
    });

    factory CommentObject.fromJson(Map<String, dynamic> json) => CommentObject(
        id: json["_id"],
        type: json["_type"],
        activityCount: json["activity_count"],
        atype: json["atype"],
        category: json["category"],
        moderation: json["moderation"],
        points: json["points"],
        state: json["state"],
        createdAt: json["created_at"],
        executeDate: json["execute_date"],
        module: json["module"],
        name: json["name"],
        team: json["team"],
        participant: Participant.fromJson(json["participant"]),
        votesCount: json["votes_count"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        participantsTags: List<dynamic>.from(json["participants_tags"].map((x) => x)),
        pushRedirectUrl: json["push_redirect_url"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "_type": type,
        "activity_count": activityCount,
        "atype": atype,
        "category": category,
        "moderation": moderation,
        "points": points,
        "state": state,
        "created_at": createdAt,
        "execute_date": executeDate,
        "module": module,
        "name": name,
        "team": team,
        "participant": participant.toJson(),
        "votes_count": votesCount,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "participants_tags": List<dynamic>.from(participantsTags.map((x) => x)),
        "push_redirect_url": pushRedirectUrl,
    };
}

class Participant {
    String id;
    String email;
    String name;
    String avatar;
    String uid;
    String uidType;
    String state;

    Participant({
        required this.id,
        required this.email,
        required this.name,
        required this.avatar,
        required this.uid,
        required this.uidType,
        required this.state,
    });

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        uid: json["uid"],
        uidType: json["uid_type"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "avatar": avatar,
        "uid": uid,
        "uid_type": uidType,
        "state": state,
    };
}
