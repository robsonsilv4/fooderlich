part of 'explore_recipe.dart';

class Instruction {

  Instruction({
    required this.imageUrl,
    required this.description,
    required this.durationInMinutes,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      durationInMinutes: json['durationInMinutes'] ?? '',
    );
  }
  String imageUrl;
  String description;
  int durationInMinutes;
}
