import 'package:flutter/material.dart';
import '../domain/models/skill_model.dart';
// Note: We are using placeholder icons (Icons.code, etc.) since we don't have all SVGs.
// Normally you'd use flutter_svg with devicon SVGs here.

class SkillsData {
  static const List<SkillModel> skills = [
    // Frontend
    SkillModel(
      name: 'Flutter',
      category: 'Frontend',
      icon: Icons.flutter_dash,
      description: 'Google\'s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
      pros: ['Single codebase for all platforms', 'High performance (60/120fps)', 'Rich library of custom widgets'],
      cons: ['Large app size for web', 'Steeper learning curve for native platform channels'],
      projectsUsedIn: 'LaptopLux, Mini Store, Portfolio',
    ),
    SkillModel(
      name: 'Dart',
      category: 'Frontend',
      icon: Icons.code,
      description: 'A client-optimized language for fast apps on any platform.',
      pros: ['JIT and AOT compilation', 'Null safety', 'Easy to learn for Java/JS devs'],
      cons: ['Smaller ecosystem outside of Flutter'],
      projectsUsedIn: 'LaptopLux, Mini Store, Portfolio',
    ),
    SkillModel(
      name: 'React',
      category: 'Frontend',
      icon: Icons.javascript,
      description: 'A JavaScript library for building user interfaces.',
      pros: ['Huge ecosystem', 'Component-based architecture', 'Virtual DOM performance'],
      cons: ['Frequent boilerplate', 'Requires many third-party libraries for full apps'],
      projectsUsedIn: 'Client Web Dashboards',
    ),
    
    // Backend
    SkillModel(
      name: 'Java (Spring Boot)',
      category: 'Backend',
      icon: Icons.coffee,
      description: 'An open-source Java-based framework used to create microservices and standalone, production-grade Spring-based Applications.',
      pros: ['Enterprise-grade security & scalability', 'Vast ecosystem', 'Excellent for complex business logic'],
      cons: ['High memory consumption', 'Verbose configuration (though Spring Boot helps)'],
      projectsUsedIn: 'TGS Ventures Flight Bookings, CRM Modules',
    ),
    SkillModel(
      name: 'Firebase',
      category: 'Backend',
      icon: Icons.local_fire_department,
      description: 'Google\'s mobile platform that helps you quickly develop high-quality apps and grow your business.',
      pros: ['Real-time database sync', 'Built-in authentication', 'Serverless architecture'],
      cons: ['Vendor lock-in', 'Complex query limitations in Firestore'],
      projectsUsedIn: 'LaptopLux, Mini Store, Portfolio',
    ),
    
    // Database
    SkillModel(
      name: 'Firestore',
      category: 'Database',
      icon: Icons.storage,
      description: 'A NoSQL document database built for automatic scaling, high performance, and ease of application development.',
      pros: ['Real-time listeners', 'Offline support', 'Scales automatically'],
      cons: ['No complex relational queries', 'Can be expensive at scale if not optimized'],
      projectsUsedIn: 'LaptopLux, Mini Store',
    ),
    SkillModel(
      name: 'MySQL',
      category: 'Database',
      icon: Icons.table_chart,
      description: 'An open-source relational database management system.',
      pros: ['ACID compliant', 'Widespread industry standard', 'Excellent for structured relational data'],
      cons: ['Harder to scale horizontally compared to NoSQL'],
      projectsUsedIn: 'TGS Ventures CRM',
    ),

    // DevOps / Tools
    SkillModel(
      name: 'Git & GitHub',
      category: 'DevOps/Tools',
      icon: Icons.merge_type,
      description: 'Version control system and code hosting platform for collaboration and deployment.',
      pros: ['Industry standard', 'GitHub Actions for CI/CD', 'Distributed version control'],
      cons: ['Complex merge conflict resolution sometimes'],
      projectsUsedIn: 'All Projects',
    ),
    
    // Other
    SkillModel(
      name: 'Riverpod',
      category: 'Other',
      icon: Icons.water_drop,
      description: 'A reactive caching and data-binding framework for Flutter.',
      pros: ['Compile-time safe', 'No BuildContext required for reads', 'Excellent testability'],
      cons: ['Slightly steeper learning curve than Provider'],
      projectsUsedIn: 'Portfolio, Mini Store',
    ),
  ];
}
