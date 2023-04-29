class Category {
  String id;
  String category;

  Category({required this.id, required this.category});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["mapel_id"],
      category: json["nama"],
    );
  }
}

class Status {
  String key;
  String value;

  Status({required this.key, required this.value});
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      key: json['key'],
      value: json['value']!,
    );
  }
}
