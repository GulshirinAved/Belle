abstract class JsonSerializer<T> {
  const JsonSerializer();

  factory JsonSerializer.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented');
  }

  Map<String, dynamic> toJson();
}
