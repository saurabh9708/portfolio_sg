import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_util.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../../hero_header/presentation/screens/hero_section.dart';
import '../../about/presentation/screens/about_section.dart';
import '../../skills/presentation/screens/skills_section.dart';
import '../../projects/presentation/screens/projects_section.dart';
import '../../experience/presentation/screens/experience_section.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _activeIndex = 0;

  // We will pass these keys to each section to scroll to them.
  final List<GlobalKey> _sectionKeys = List.generate(6, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 80 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 80 && _isScrolled) {
      setState(() => _isScrolled = false);
    }

    // Determine active section based on scroll offset
    // (This is a simplified approach; ideally we check which section is most visible)
    _updateActiveIndexOnScroll();
  }

  void _updateActiveIndexOnScroll() {
    // Basic logic mapping scroll position to sections. 
    // In a fully built app, you might use VisibilityDetector on each section to update state.
  }

  void _scrollToSection(int index) {
    setState(() {
      _activeIndex = index;
    });

    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Main Scroll View
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(sectionKey: _sectionKeys[0]),
                AboutSection(sectionKey: _sectionKeys[1]),
                SkillsSection(sectionKey: _sectionKeys[2]),
                ProjectsSection(sectionKey: _sectionKeys[3]),
                ExperienceSection(sectionKey: _sectionKeys[4]),
                // Placeholders for sections until they are built
                _buildSectionPlaceholder(5, 'Contact Section', 700, keyless: true),
                _buildSectionPlaceholder(6, 'Footer', 200, keyless: true),
              ],
            ),
          ),

          // Top Nav (Tablet/Desktop)
          if (!ResponsiveLayout.isMobile(context))
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TopNavBar(
                scrollController: _scrollController,
                isScrolled: _isScrolled,
                onNavTap: _scrollToSection,
                activeIndex: _activeIndex,
              ),
            ),
            
          // Bottom Nav (Mobile)
          if (ResponsiveLayout.isMobile(context))
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(
                activeIndex: _activeIndex,
                onNavTap: _scrollToSection,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionPlaceholder(int index, String title, double height, {bool keyless = false}) {
    return Container(
      key: keyless ? null : _sectionKeys[index],
      height: height,
      width: double.infinity,
      color: index.isEven ? Colors.blueGrey.withOpacity(0.1) : Colors.transparent,
      alignment: Alignment.center,
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}
