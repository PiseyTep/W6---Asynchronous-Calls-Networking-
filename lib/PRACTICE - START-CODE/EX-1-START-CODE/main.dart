import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/courses_provider.dart';
import 'repositories/courses_repository.dart';
import 'repositories/courses_mock_repository.dart';
import 'screens/course_list_screen.dart';

void main() {
  // 1 - repository and services
  CoursesRepository coursesRepo = CoursesMockRepository();

  runApp(
    ChangeNotifierProvider(
      // 2 -  providers
      create: (BuildContext context) {
        return CoursesProvider(repository: coursesRepo);
      },

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CoursesListScreen(),
      ),
    ),
  );
}
