import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';

void main() {
  final students = [
    Student('01', '李华', 92),
    Student('02', '王芳', 55),
    Student.fromJson({'id': '03', 'name': '张伟', 'score': 78}),
    Student.fromJson({'id': '04', 'name': '刘洋'}), // 故意缺 score，测兜底
  ];

  final book = GradeBook(students);
  for (final s in book.students) {
    print('${s.id} ${s.name} 分数=${s.score} 及格=${s.passed}');
  }
  print(book);

  students.first.score = 100; // setter 正常
  // students.first.score = 200; // 取消注释会抛 ArgumentError
  print('改分后：${students.first.name} -> ${students.first.score}');
}
