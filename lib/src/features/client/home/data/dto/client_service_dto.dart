class ClientServiceDto {
  final String? iconPath;
  final int? id;
  final String? name;
  final String? slug;

  const ClientServiceDto({
    this.iconPath,
    this.id,
    this.name,
    this.slug,
  });

  factory ClientServiceDto.fromJson(Map<String, dynamic> json) {
    return ClientServiceDto(
      iconPath: json['icon_path'] as String?,
      id: json['service_id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon_path': iconPath,
      'service_id': id,
      'name': name,
      'slug': slug,
    };
  }

  ClientServiceDto copyWith({
    String? iconPath,
    int? id,
    String? name,
    String? slug,
  }) {
    return ClientServiceDto(
      iconPath: iconPath ?? this.iconPath,
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }
}
