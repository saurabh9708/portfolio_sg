enum ProjectStatus { live, comingSoon }

class ProjectModel {
  final String title;
  final String description;
  final String liveUrl;
  final String imagePath; // We'll mock this for now
  final List<String> techStack;
  final ProjectStatus status;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.liveUrl,
    this.imagePath = 'assets/images/project_placeholder.png', // Fallback
    required this.techStack,
    required this.status,
  });
}
