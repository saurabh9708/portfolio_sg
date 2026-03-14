import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final String category;
  final IconData icon;
  final String description;
  final List<String> pros;
  final List<String> cons;
  final String projectsUsedIn;

  const SkillModel({
    required this.name,
    required this.category,
    required this.icon,
    required this.description,
    required this.pros,
    required this.cons,
    required this.projectsUsedIn,
  });
}
