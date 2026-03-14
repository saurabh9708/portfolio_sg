class ExperienceModel {
  final String role;
  final String company;
  final String duration;
  final String location;
  final List<String> bulletPoints;
  final List<String> techStack;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.bulletPoints,
    required this.techStack,
  });
}
