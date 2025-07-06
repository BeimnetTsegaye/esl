class Faculty {
  final String id;
  final String name;
  final String? description;

  Faculty({required this.id, required this.name, required this.description});

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
}
