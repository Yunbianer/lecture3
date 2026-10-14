/// 单个学生：成绩册里的最小建模单元。
class Student {
  final String id;
  final String name;
  double _score; // 下划线前缀 = 库内私有

  /// 位置参数构造：分数可选，默认 0。
  Student(this.id, this.name, [this._score = 0]);

  /// 命名构造：从 Map/JSON 造对象，第 11 课网络数据解析的标准入口。
  /// 不假设后端一定返回全量字段，统一做可空转换 + 默认值兜底。
  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String? ?? '',
        name = json['name'] as String? ?? '',
        _score = (json['score'] as num?)?.toDouble() ?? 0;

  /// getter：只读暴露分数。
  double get score => _score;

  /// setter 带校验，越界直接抛错，而不是悄悄把数据改坏。
  set score(double v) {
    if (v < 0 || v > 100) throw ArgumentError('分数越界：$v');
    _score = v;
  }

  bool get passed => _score >= 60;

  @override
  String toString() => 'Student($id, $name, $_score)';
}
