import 'package:emory_app/data/models/user_model.dart';
import 'package:emory_app/domain/entities/user_pagination_entity.dart';

/// class [UserPaginationModel]
class UserPaginationModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> data;

  /// [UserPaginationModel] constructor
  UserPaginationModel(
      {required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages,
      required this.data});

  /// funtuk generate otomatis object [UserPaginationModel] dari json
  factory UserPaginationModel.fromJson(Map<String, dynamic> json) =>
      UserPaginationModel(
          page: json['page'] ?? 0,
          perPage: json['per_page'] ?? 0,
          total: json['total'] ?? 0,
          totalPages: json['total_pages'] ?? 0,
          data: List.from(json['data'].map((x) => UserModel.fromJson(x))));

  /// [toEntity] untuk generate otomatis menjadi entitas
  UserPaginationEntity toEntity() => UserPaginationEntity(
      page: page,
      perPage: perPage,
      total: total,
      totalPages: totalPages,
      data: List.from(data.map((e) => e.toEntity())));
}
