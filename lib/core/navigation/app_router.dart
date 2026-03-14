import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/navigation/presentation/screens/main_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            key: ValueKey('home'),
            child: MainScreen(),
            transitionsBuilder: _fadeSlideTransition,
          );
        },
      ),
    ],
  );

  static Widget _fadeSlideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.05), // from bottom 24px approx based on view height
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        )),
        child: child,
      ),
    );
  }
}
