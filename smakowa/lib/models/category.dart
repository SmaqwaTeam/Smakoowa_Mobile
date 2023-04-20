class Categories {
  final int id;
  final String categoryName;

  Categories({
    required this.id,
    required this.categoryName,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      categoryName: json['name'],
    );
  }
}
