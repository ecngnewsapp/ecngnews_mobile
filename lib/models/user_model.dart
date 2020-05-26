class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final List<dynamic> bookmarkedItems;
  final List<dynamic> lovedItems;
  User({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.lovedItems,
    this.bookmarkedItems,
  });

  User.fromData(
    Map<String, dynamic> data,
  )   : id = data['id'],
        name = data['name'],
        email = data['email'],
        avatar = data['image url'],
        lovedItems = data['loved items'],
        bookmarkedItems = data['bookmarked items'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image url': avatar,
      'loved items': lovedItems,
      'bookmarked items': bookmarkedItems,
    };
  }
}
