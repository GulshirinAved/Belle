import 'dart:convert';
import 'dart:io';

void main() async {
  print('Введите название главной модели (например, ClientBookingsDto):');
  String? mainModelName = stdin.readLineSync();

  if (mainModelName == null || mainModelName.isEmpty) {
    print('Название модели не может быть пустым.');
    return;
  }

  print('Введите JSON-данные (завершите ввод строкой END):');
  final buffer = StringBuffer();
  while (true) {
    final line = stdin.readLineSync();
    if (line == 'END') break;
    buffer.writeln(line);
  }

  try {
    final jsonData = json.decode(buffer.toString());
    print('JSON успешно обработан: $jsonData');
    final models = generateModels(mainModelName, jsonData);

    final directory = Directory('generated_models');
    if (!directory.existsSync()) {
      directory.createSync();
    }

    for (final entry in models.entries) {
      final file = File(
          '${directory.path}/${toSnakeCase(entry.key).toLowerCase()}.dart');
      file.writeAsStringSync(entry.value);
    }

    print('Модели сгенерированы и сохранены в папке generated_models!');
  } catch (e) {
    print('Ошибка при обработке JSON: $e');
  }
}

Map<String, String> generateModels(
    String mainModelName, Map<String, dynamic> jsonData) {
  final Map<String, String> models = {};

  // void processModel(String modelName, Map<String, dynamic> json) {
  //   final buffer = StringBuffer();
  //
  //   buffer.writeln("import 'package:meta/meta.dart';");
  //   buffer.writeln();
  //   buffer.writeln('/// Модель $modelName');
  //   buffer.writeln('@immutable');
  //   buffer.writeln('class $modelName {');
  //
  //   json.forEach((key, value) {
  //     final type = getType(value);
  //     if(value is Map) {
  //       final nestedModelName = capitalize(toCamelCase(key));
  //       buffer.writeln('  final $nestedModelName? ${toCamelCase(key)};');
  //     }
  //     else {
  //       buffer.writeln('  final $type? ${toCamelCase(key)};');
  //     }
  //
  //   });
  //
  //   buffer.writeln();
  //   buffer.writeln('  const $modelName({');
  //   json.forEach((key, value) {
  //     buffer.writeln('    this.${toCamelCase(key)},');
  //   });
  //   buffer.writeln('  });');
  //
  //   buffer.writeln();
  //   buffer.writeln('  factory $modelName.fromJson(Map<String, dynamic> json) {');
  //   buffer.writeln('    return $modelName(');
  //   json.forEach((key, value) {
  //     if (value is Map<String, dynamic>) {
  //       final nestedModelName = capitalize(toCamelCase(key));
  //       buffer.writeln("      ${toCamelCase(key)}: json['$key'] != null ? $nestedModelName.fromJson(json['$key']) : null,");
  //       processModel(nestedModelName, value);
  //     } else {
  //       buffer.writeln("      ${toCamelCase(key)}: json['$key'] as ${getType(value)}?,");
  //     }
  //   });
  //   buffer.writeln('    );');
  //   buffer.writeln('  }');
  //
  //   buffer.writeln();
  //   buffer.writeln('  Map<String, dynamic> toJson() {');
  //   buffer.writeln('    return {');
  //   json.forEach((key, value) {
  //     buffer.writeln("      '$key': ${toCamelCase(key)}${value is Map<String, dynamic> ? '?.toJson()' : ''},");
  //   });
  //   buffer.writeln('    };');
  //   buffer.writeln('  }');
  //
  //   buffer.writeln('}');
  //   models[modelName] = buffer.toString();
  // }
  void processModel(String modelName, Map<dynamic, dynamic> json) {
    final buffer = StringBuffer();

    buffer.writeln("import 'package:flutter/foundation.dart';");
    buffer.writeln();
    buffer.writeln('/// Модель $modelName');
    buffer.writeln('@immutable');
    buffer.writeln('class $modelName {');

    json.forEach((key, value) {
      if (value is Map) {
        final nestedModelName = capitalize(toCamelCase(key));
        buffer.writeln('  final $nestedModelName? ${toCamelCase(key)};');
        processModel(nestedModelName, value);
      } else if (value is List) {
        final nestedModelName = value.isNotEmpty && value.first is Map
            ? capitalize(toCamelCase(key))
            : 'dynamic';
        buffer.writeln('  final List<$nestedModelName>? ${toCamelCase(key)};');
        if (value.isNotEmpty && value.first is Map) {
          processModel(nestedModelName, value.first as Map<String, dynamic>);
        }
      } else {
        final type = getType(value);
        buffer.writeln('  final $type? ${toCamelCase(key)};');
      }
    });

    buffer.writeln();
    buffer.writeln('  const $modelName({');
    json.forEach((key, value) {
      buffer.writeln('    this.${toCamelCase(key)},');
    });
    buffer.writeln('  });');

    buffer.writeln();
    buffer
        .writeln('  factory $modelName.fromJson(Map<String, dynamic> json) {');
    buffer.writeln('    return $modelName(');
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        final nestedModelName = capitalize(toCamelCase(key));
        buffer.writeln(
            "      ${toCamelCase(key)}: json['$key'] != null ? $nestedModelName.fromJson(json['$key']) : null,");
      } else if (value is List) {
        final nestedModelName = value.isNotEmpty && value.first is Map
            ? capitalize(toCamelCase(key))
            : 'dynamic';
        buffer.writeln(
            "      ${toCamelCase(key)}: json['$key'] != null ? (json['$key'] as List).map((item) => item != null ? $nestedModelName.fromJson(item as Map<String, dynamic>) : null).toList() : null,");
      } else {
        buffer.writeln(
            "      ${toCamelCase(key)}: json['$key'] as ${getType(value)}?,");
      }
    });
    buffer.writeln('    );');
    buffer.writeln('  }');

    buffer.writeln();
    buffer.writeln('  Map<String, dynamic> toJson() {');
    buffer.writeln('    return {');
    json.forEach((key, value) {
      if (value is Map) {
        buffer.writeln("      '$key': ${toCamelCase(key)}${'?.toJson()'},");
      } else if (value is List) {
        buffer.writeln(
            "      '$key': ${toCamelCase(key)}?.map((item) => item?.toJson()).toList(),");
      } else {
        buffer.writeln("      '$key': ${toCamelCase(key)},");
      }
    });
    buffer.writeln('    };');
    buffer.writeln('  }');

    buffer.writeln('}');
    models[modelName] = buffer.toString();
  }

  processModel(mainModelName, jsonData);
  return models;
}

String getType(dynamic value) {
  if (value is int) return 'int';
  if (value is double) return 'double';
  if (value is bool) return 'bool';
  if (value is Map) return 'Map<String, dynamic>';
  if (value is List) return 'List<dynamic>';
  return 'String';
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String toSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'(?<!^)([A-Z])'), (Match match) {
    return '_${match.group(0)!.toLowerCase()}';
  }).toLowerCase();
}

String toCamelCase(String input) {
  final parts = input.split('_');
  return parts.first +
      parts
          .skip(1)
          .map((part) => part[0].toUpperCase() + part.substring(1))
          .join();
}
