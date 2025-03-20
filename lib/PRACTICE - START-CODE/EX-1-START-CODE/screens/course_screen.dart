import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/courses_provider.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId});

  final String courseId;

  void _addScore(BuildContext context) async {
    CourseScore? newScore = await Navigator.of(
      context,
    ).push<CourseScore>(MaterialPageRoute(builder: (ctx) => CourseScoreForm()));

    if (newScore != null) {
      // Use the provider to add the score
      final coursesProvider = Provider.of<CoursesProvider>(
        context,
        listen: false,
      );
      coursesProvider.addScore(courseId, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    // Use the provider to get the course data
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final Course? course = coursesProvider.getCourseFor(courseId);

    if (course == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Not Found')),
        body: const Center(child: Text('Course not found')),
      );
    }

    Widget content = const Center(child: Text('No Scores added yet.'));
    if (course.hasScore) {
      content = ListView.builder(
        itemCount: course.scores.length,
        itemBuilder:
            (ctx, index) => ListTile(
              title: Text(course.scores[index].studentName),
              trailing: Text(
                course.scores[index].studenScore.toString(),
                style: TextStyle(
                  color: scoreColor(course.scores[index].studenScore),
                  fontSize: 15,
                ),
              ),
            ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(course.name, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => _addScore(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
