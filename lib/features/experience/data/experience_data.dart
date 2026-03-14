import '../domain/models/experience_model.dart';

class ExperienceData {
  static const List<ExperienceModel> experienceList = [
    ExperienceModel(
      role: 'Flutter Developer – Fiverr Pro Seller',
      company: 'Self-Employed',
      duration: '2026 – Present',
      location: 'Remote / Global Clients',
      bulletPoints: [
        'Delivering end-to-end Flutter applications for clients across fintech, healthtech, and e-commerce.',
        'Handling full project lifecycle — from architecture and UI design to Firebase integration and App Store deployment.',
        'Working with Firebase, Supabase, and AWS to build scalable, production-ready mobile and web apps.',
      ],
      techStack: ['Flutter', 'Firebase', 'Supabase', 'AWS'],
    ),
    ExperienceModel(
      role: 'Java Backend Developer',
      company: 'TGS Ventures Pvt Ltd',
      duration: 'May 2024 – Jan 2026',
      location: 'Noida, India',
      bulletPoints: [
        'Designed and maintained scalable backend services for airline booking platforms (farehutz.us, farehutz.co.uk).',
        'Built a CRM module for agents using Spring Boot to manage customer bookings and requests.',
        'Integrated third-party APIs to fetch booking details and present them in an agent dashboard.',
        'Developed an interactive mailer system enabling agents to send booking-related emails to customers.',
        'Boosted API response times by 20%, improving overall customer booking efficiency.',
      ],
      techStack: ['Java', 'Spring Boot', 'MySQL', 'REST API'],
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Petukji Pvt Ltd',
      duration: 'Dec 2023 – Apr 2024',
      location: 'Meerut (Remote)',
      bulletPoints: [
        'Collaborated with the Flutter team to build and ship the Petukji seller tool — empowering local sellers to list and sell products seamlessly across Android, iOS, and Web.',
        'Integrated Firebase for real-time data sync and Google Maps API for location-based features.',
        'Ensured app quality and compatibility for Play Store and App Store deployment.',
      ],
      techStack: ['Flutter', 'Firebase', 'Google Maps API'],
    ),
  ];
}
