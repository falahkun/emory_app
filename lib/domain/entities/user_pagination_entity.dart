import 'package:emory_app/domain/entities/user_entity.dart';

class UserPaginationEntity {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserEntity> data;

  /// user pagination model constructor
  const UserPaginationEntity(
      {required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages,
      required this.data});
}

class UserPaginationEmpty extends UserPaginationEntity {
  UserPaginationEmpty(
      {super.page = 0,
      super.perPage = 0,
      super.total = 0,
      super.totalPages = 0,
      super.data = const []});
}
