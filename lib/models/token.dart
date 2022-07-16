class Token {
  Token._internal([String? token]) : _token = token;

  factory Token.empty() {
    return Token._internal();
  }

  factory Token.of(String? token) {
    return Token._internal(token);
  }

  final String? _token;

  String get value => _token ?? "";
  bool get notExists => _token == null;
  bool get exists => _token != null && _token!.isNotEmpty;
}
