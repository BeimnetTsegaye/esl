class Department {
  final String id;
  final String name;
  final String facultyId;

  Department({required this.id, required this.name, required this.facultyId});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as String,
      name: json['name'] as String,
      facultyId: json['facultyId'] as String,
    );
  }
}
