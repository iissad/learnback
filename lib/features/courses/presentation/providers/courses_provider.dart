import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/core/providers/common_providers.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/models/course.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepositoryImpl(dio: ref.watch(dioProvider));
});

final availableCoursesProvider = FutureProvider<List<Course>>((ref) async {
  final repo = ref.watch(courseRepositoryProvider);
  return repo.getAvailableCourses();
});
