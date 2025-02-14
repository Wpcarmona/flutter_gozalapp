import 'package:meta/meta.dart';
import 'dart:convert';

GetCommentResponse getCommentResponseFromJson(String str) => GetCommentResponse.fromJson(json.decode(str));

String getCommentResponseToJson(GetCommentResponse data) => json.encode(data.toJson());

class GetCommentResponse {
    int page;
    int pageSize;
    int totalPages;
    int totalData;
    List<Comment> comments;

    GetCommentResponse({
        required this.page,
        required this.pageSize,
        required this.totalPages,
        required this.totalData,
        required this.comments,
    });

    factory GetCommentResponse.fromJson(Map<String, dynamic> json) => GetCommentResponse(
        page: json["page"],
        pageSize: json["page_size"],
        totalPages: json["total_pages"],
        totalData: json["total_data"],
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "page_size": pageSize,
        "total_pages": totalPages,
        "total_data": totalData,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    String id;
    String body;
    String name;
    String avatar;
    DateTime executeDate;

    Comment({
        required this.id,
        required this.body,
        required this.name,
        required this.avatar,
        required this.executeDate,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        body: json["body"],
        name: json["name"],
        avatar: json["avatar"],
        executeDate: DateTime.parse(json["execute_date"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "body": body,
        "name": name,
        "avatar": avatar,
        "execute_date": executeDate.toIso8601String(),
    };
}
