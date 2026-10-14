import 'package:dart_oo/gradebook.dart';
import 'package:dart_oo/student.dart';
import 'package:test/test.dart';

void main() {
  group('GradeBook 正常数据统计', () {
    late GradeBook book;

    setUp(() {
      book = GradeBook([
        Student('01', '李华', 92),
        Student('02', '王芳', 55),
        Student('03', '张伟', 78),
        Student('04', '刘洋', 90),
      ]);
    });

    test('average 平均分正确', () {
      expect(book.average, closeTo(78.75, 1e-9));
    });

    test('maxBy 返回最高分学生', () {
      expect(book.maxBy?.name, '李华');
      expect(book.maxBy?.score, 92);
    });

    test('countPassed 及格人数正确', () {
      expect(book.countPassed, 3);
    });

    test('groupByGrade 分档正确', () {
      final grouped = book.groupByGrade;
      expect(grouped['优']?.map((s) => s.name).toList(), ['李华', '刘洋']);
      expect(grouped['中']?.map((s) => s.name).toList(), ['张伟']);
      expect(grouped['不及格']?.map((s) => s.name).toList(), ['王芳']);
      expect(grouped.containsKey('良'), isFalse); // 本组无人落入「良」
    });
  });

  test('越界分数抛 ArgumentError', () {
    expect(() {
      Student('99', '越界').score = 101;
    }, throwsArgumentError);
  });
}
