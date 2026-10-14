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

  print('平均分：${book.average}');
  print('最高分：${book.maxBy?.name} (${book.maxBy?.score})');
  print('及格人数：${book.countPassed} / ${book.count}');

  final grouped = book.groupByGrade;
  for (final grade in ['优', '良', '中', '不及格']) {
    final list = grouped[grade] ?? const <Student>[];
    final names = list.map((s) => s.name).join('、');
    print('$grade(${list.length})：$names');
  }

  book.log('统计完成'); // 来自 mixin Logger，方括号里是运行时类型
}
