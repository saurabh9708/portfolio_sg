import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (optional/mocked for now)
  // try {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // } catch (e) {
  //   debugPrint('Firebase init failed or missing options: $e');
  // }

  runApp(
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
