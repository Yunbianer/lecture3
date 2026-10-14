# dart_oo —— 第 3 课作业（用类组织程序，用集合组织数据）

把「课程成绩册」用类建模，并用集合链式方法完成统计。

## 目录结构

- `lib/student.dart`：Student 类。私有字段 `_score`、命名构造 `fromJson`、带校验的 setter、getter `score` / `passed`，混入 `Logger`
- `lib/gradebook.dart`：GradeBook 类。内部持有 `List<Student>`（构造时复制、对外只读），统计方法 `average` / `maxBy` / `countPassed` / `groupByGrade` / `passedScoresDesc`，混入 `Logger`
- `lib/logger.dart`：`mixin Logger`，可被任意类混入的日志能力
- `bin/dart_oo.dart`：运行入口，打印统计结果
- `test/gradebook_test.dart`：单元测试，覆盖正常统计与越界异常
- `进度报告.md`：本课完成情况与 AI 使用标注

## 运行与测试

```bash
dart pub get
dart run dart_oo
dart test
```

## 设计说明：为什么日志用 mixin 而不是继承

最初设想让 `GradeBook` 继承一个日志基类来获得打印能力，最终改为 `mixin Logger`。理由：

1. 日志是「能力」不是「身份」。日志跟「成绩册是什么」没有 is-a 关系，用继承会把一个实现细节写进类型血缘里；
2. Dart 是单继承。用继承拿日志，会白白占掉唯一的父类名额，将来真需要基类时无处可放；
3. `Logger` 能被 `Student`、`GradeBook` 这两个互不相干的类同时 `with` 复用，这正是 mixin 的定位。

`groupByGrade` 按 `优(≥90) / 良(≥80) / 中(≥60) / 不及格` 分档，只收录「有人」的档位，未出现的档位不会出现在 Map 里。
