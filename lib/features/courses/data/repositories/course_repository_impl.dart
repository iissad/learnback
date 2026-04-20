import 'package:dio/dio.dart';
import '../../domain/models/course.dart';
import '../../domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final Dio _dio;

  CourseRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<Course>> getAvailableCourses() async {
    final response = await _dio.get('courses/list');
    final responseBody = response.data as Map<String, dynamic>;
    final List<dynamic> data = responseBody['data'] as List<dynamic>;

    return data
        .map((json) => Course.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
