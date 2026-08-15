part of 'explore_recipe.dart';

class Instruction {
  Instruction({
    required this.imageUrl,
    required this.description,
    required this.durationInMinutes,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      imageUrl: json['imageUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
      durationInMinutes: json['durationInMinutes'] as int? ?? 0,
    );
  }
  String imageUrl;
  String description;
  int durationInMinutes;
}
