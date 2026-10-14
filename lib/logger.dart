/// 跨类复用的日志能力：任何类 `with Logger` 都能拿到 log 方法。
mixin Logger {
  void log(String msg) => print('[$runtimeType] $msg');
}
