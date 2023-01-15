class FishType {
  int id;
  String name;
  

  FishType({required this.id, required this.name});

  factory FishType.fromJson(Map<String, dynamic> json) {
    return FishType(id: json['id'] as int, name: json['name'].toString());
  }

  String getName() {
    return name;
  }
}
