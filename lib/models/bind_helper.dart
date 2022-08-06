mixin BindHelper {
  bool hasNot(Map<String, dynamic> json, String key) => !json.containsKey(key);

  String getString(Map<String, dynamic> json, String key) {
    if (hasNot(json, key)) {
      return "";
    }

    final value = json[key];
    if (value == null) {
      return "";
    }

    return value as String;
  }

  int getInt(Map<String, dynamic> json, String key) {
    if (hasNot(json, key)) {
      return 0;
    }

    final value = json[key];
    if (value == null) {
      return 0;
    }

    return json[key] as int;
  }

  DateTime? getDateTime(Map<String, dynamic> json, String key) {
    if (hasNot(json, key)) {
      return null;
    }

    try {
      final tmp = json[key] as String;
      return DateTime.parse(tmp);
    } on Exception {
      return null;
    }
  }

  Map<String, dynamic> getMap(Map<String, dynamic> json, String key) {
    if (hasNot(json, key)) {
      return <String, dynamic>{};
    }

    final value = json[key];
    if (value == null) {
      return <String, dynamic>{};
    }

    return json[key] as Map<String, dynamic>;
  }
}
