import 'student.dart';

/// 课程成绩册：内部持有一份学生列表。
class GradeBook {
  final List<Student> _students;

  /// 构造时复制一份，避免与外部列表共享同一个对象。
  GradeBook(List<Student> students) : _students = List.of(students);

  /// 只读视图：对外能读不能改。
  List<Student> get students => List.unmodifiable(_students);

  int get count => _students.length;

  @override
  String toString() => 'GradeBook($count 名学生)';
}
