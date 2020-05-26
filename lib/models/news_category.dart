class NewsCategory {
  final String categories;
  final String avatar;
  NewsCategory({this.categories, this.avatar});
}

enum Categories {
  GENERAL,
  BUSINESS,
  TECHNOLOGY,
  SPORTS,
  ENTERTAINMENT,
  HEALTH,
  SCIENCE
}

final categoryValues = EnumValues({
  "Business": Categories.BUSINESS,
  "Entertainment": Categories.ENTERTAINMENT,
  "General": Categories.GENERAL,
  "Health": Categories.HEALTH,
  "Science": Categories.SCIENCE,
  "Sports": Categories.SPORTS,
  "Technology": Categories.TECHNOLOGY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
