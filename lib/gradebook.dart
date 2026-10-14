import 'logger.dart';
import 'student.dart';

/// 课程成绩册：内部持有一份学生列表。
/// 混入 Logger 获得 log 能力（日志不是继承关系，用 mixin 跨类复用）。
class GradeBook with Logger {
  final List<Student> _students;

  /// 构造时复制一份，避免与外部列表共享同一个对象。
  GradeBook(List<Student> students) : _students = List.of(students);

  /// 只读视图：对外能读不能改。
  List<Student> get students => List.unmodifiable(_students);

  int get count => _students.length;

  /// 平均分：用 fold 求和再除以人数；空册返回 0，避免除以 0。
  double get average => _students.isEmpty
      ? 0
      : _students.fold<double>(0, (sum, s) => sum + s.score) /
          _students.length;

  /// 最高分学生：用 reduce 两两比出较大者；空册返回 null。
  Student? get maxBy => _students.isEmpty
      ? null
      : _students.reduce((a, b) => a.score >= b.score ? a : b);

  /// 及格人数：where 筛选 + length。
  int get countPassed => _students.where((s) => s.passed).length;

  /// 按 优/良/中/不及格 分档，返回 `Map<String, List<Student>>`。
  /// 用 fold 累积分组，不手写 for 循环。
  Map<String, List<Student>> get groupByGrade =>
      _students.fold(<String, List<Student>>{}, (acc, s) {
        (acc[_gradeOf(s.score)] ??= <Student>[]).add(s);
        return acc;
      });

  /// 及格学生分数（降序）—— 一组统计由 6 个链式调用串成：
  /// `where → map → toList → sort → map → join`，全程不手写 for。
  String get passedScoresDesc {
    final scores = _students.where((s) => s.passed).map((s) => s.score).toList()
      ..sort((a, b) => b.compareTo(a));
    return scores.map((v) => v.toStringAsFixed(0)).join('、');
  }

  static String _gradeOf(double score) {
    if (score >= 90) return '优';
    if (score >= 80) return '良';
    if (score >= 60) return '中';
    return '不及格';
  }

  @override
  String toString() => 'GradeBook($count 名学生)';
}
