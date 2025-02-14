class GetComment{
  final String id;
  final String text;
  final String nameUser;
  final String imageUser;
  final String date;

  GetComment({
    required this.id, 
    required this.text,
    required this.nameUser, 
    required this.imageUser,
    required this.date});
}

class CreateComment {
  final String ok;
  final String message;

  CreateComment({
    required this.ok,
    required this.message});
}