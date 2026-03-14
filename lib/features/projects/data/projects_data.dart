import '../domain/models/project_model.dart';

class ProjectsData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'LaptopLux',
      description: 'A full-featured e-commerce platform for buying and selling used laptops and accessories. Features product listings, search/filter, Firebase backend, and clean UI.',
      liveUrl: 'https://laptoplux-cfd33.firebaseapp.com/',
      techStack: ['Flutter Web', 'Firebase', 'Firestore', 'Firebase Storage'],
      status: ProjectStatus.live,
    ),
    ProjectModel(
      title: 'Mini Store',
      description: 'A compact online storefront for grocery and everyday essentials, designed for small local businesses.',
      liveUrl: '#', // Placeholder URL Since 'coming soon'
      techStack: ['Flutter', 'Firebase'],
      status: ProjectStatus.comingSoon,
    ),
  ];
}
