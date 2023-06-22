class UserModel {
  final String id;
  final String name;

  const UserModel({
    required this.name,
    required this.id,
  });
}

final List<UserModel> usersList = [
  const UserModel(
    name: "Rafid",
    id: "101",
  ),
  const UserModel(
    name: "Touhid",
    id: "102",
  ),
  const UserModel(
    name: "Mausum",
    id: "103",
  ),
];
