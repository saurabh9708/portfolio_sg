import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../data/projects_data.dart';
import 'widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({super.key, required this.sectionKey});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_isVisible) {
      if (mounted) setState(() => _isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        key: widget.sectionKey,
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPaddingVDesktop),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveLayout.isMobile(context)
                    ? AppSizes.sectionPaddingHMobile
                    : AppSizes.sectionPaddingHTablet,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.projectsTitle,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideX(begin: -0.1),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms),
                  const SizedBox(height: 48),
                  
                  // Responsiveness for Projects Grid
                  if (ResponsiveLayout.isMobile(context))
                    _buildMobileScroll()
                  else
                    _buildDesktopGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
      ),
      itemCount: ProjectsData.projects.length,
      itemBuilder: (context, index) {
        return ProjectCard(project: ProjectsData.projects[index])
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(delay: Duration(milliseconds: 200 + (index * 120)), duration: 600.ms)
            .scaleXY(begin: 0.9, end: 1.0, delay: Duration(milliseconds: 200 + (index * 120)), duration: 600.ms, curve: Curves.easeOutBack);
      },
    );
  }

  Widget _buildMobileScroll() {
    return SizedBox(
      height: 400, // Fixed height for horizontal scroll item on mobile
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: ProjectsData.projects.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.85,
            child: ProjectCard(project: ProjectsData.projects[index])
              .animate(target: _isVisible ? 1 : 0)
              .fadeIn(delay: Duration(milliseconds: 200 + (index * 120)), duration: 600.ms)
              .slideX(begin: 0.1, end: 0, delay: Duration(milliseconds: 200 + (index * 120)), duration: 600.ms, curve: Curves.easeOutCubic),
          );
        },
      ),
    );
  }
}
