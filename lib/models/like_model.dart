class LikeModel {
  String userId;
  LikeModel({
    this.userId,
  });
  LikeModel.fromJson(Map<String, dynamic> json) : userId = json['id'];
  Map<String, dynamic> toJson() {
    return {'id': userId};
  }
}
