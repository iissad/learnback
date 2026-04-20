class Course {
  final String title;
  final int requiredPoints;

  Course({required this.title, required this.requiredPoints});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] as String,
      requiredPoints: json['requiredPoints'] as int,
    );
  }
}
