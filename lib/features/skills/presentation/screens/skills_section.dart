import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../data/skills_data.dart';
import '../../domain/models/skill_model.dart';
import '../widgets/skill_card.dart';
import '../widgets/tool_detail_panel.dart';

class SkillsSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const SkillsSection({super.key, required this.sectionKey});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;
  SkillModel? _selectedSkill;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_isVisible) {
      if (mounted) setState(() => _isVisible = true);
    }
  }

  void _onSkillTap(SkillModel skill) {
    if (ResponsiveLayout.isMobile(context)) {
      _showMobileBottomSheet(skill);
    } else {
      setState(() {
        _selectedSkill = skill;
      });
    }
  }

  void _showMobileBottomSheet(SkillModel skill) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: AppColors.border),
          ),
          child: ToolDetailContent(skill: skill),
        ).animate().slideY(begin: 1.0, end: 0.0, curve: Curves.elasticOut, duration: 600.ms);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('skills-section'),
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
                    AppStrings.skillsTitle,
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
                  
                  // Layout changes based on platform
                  if (ResponsiveLayout.isMobile(context))
                    _buildGrid(SkillsData.skills)
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: _buildGrid(SkillsData.skills)),
                        if (_selectedSkill != null) ...[
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: ToolDetailContent(
                                key: ValueKey(_selectedSkill!.name),
                                skill: _selectedSkill!,
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<SkillModel> skills) {
    // Dynamic crossAxisCount based on screen width + presence of side panel
    int crossAxisCount = 2;
    if (ResponsiveLayout.isDesktop(context)) {
      crossAxisCount = _selectedSkill == null ? 4 : 2;
    } else if (ResponsiveLayout.isTablet(context)) {
      crossAxisCount = _selectedSkill == null ? 3 : 2;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return SkillCard(
              skill: skills[index],
              onTap: () => _onSkillTap(skills[index]),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(
                  delay: Duration(milliseconds: 200 + (index * 80)),
                  duration: 600.ms,
                ).slideY(
                  begin: 0.1,
                  end: 0,
                  delay: Duration(milliseconds: 200 + (index * 80)),
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                );
          },
        );
      }
    );
  }
}
