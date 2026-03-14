import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../../../core/widgets/typewriter_text.dart';
import '../widgets/animated_mesh_background.dart';
import '../widgets/profile_image_widget.dart';
import '../widgets/social_links_row.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const HeroSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height,
      ),
      child: Stack(
        children: [
          // Background
          const Positioned.fill(
            child: AnimatedMeshBackground(),
          ),

          // Content Wrapper
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveLayout.isMobile(context)
                      ? AppSizes.sectionPaddingHMobile
                      : AppSizes.sectionPaddingHTablet,
                ),
                child: ResponsiveLayout(
                  mobile: (_) => _buildMobileLayout(context),
                  tablet: (_) => _buildDesktopLayout(context),
                  desktop: (_) => _buildDesktopLayout(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Text Column
        Expanded(
          flex: 6,
          child: _buildTextContent(context, centered: false),
        ),
        
        // Right Image Column
        const Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: ProfileImageWidget(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppSizes.sectionPaddingVMobile),
        const ProfileImageWidget(),
        const SizedBox(height: 40),
        _buildTextContent(context, centered: true),
        const SizedBox(height: AppSizes.sectionPaddingVMobile),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool centered}) {
    CrossAxisAlignment alignment = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    TextAlign textAlign = centered ? TextAlign.center : TextAlign.left;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        // Greeting UI Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accentColor.withOpacity(0.2)),
          ),
          child: Text(
            AppStrings.greeting,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().slideX(begin: -0.2, end: 0, delay: 0.ms, duration: 600.ms, curve: AppSizes.curveOut)
         .fadeIn(duration: 600.ms),

        const SizedBox(height: 16),

        // Name
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            AppStrings.myName,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: ResponsiveLayout.isMobile(context) ? 48 : 80,
              height: 1.1,
            ),
            textAlign: textAlign,
          ),
        ).animate().slideY(begin: 0.2, end: 0, delay: 150.ms, duration: 600.ms, curve: AppSizes.curveOut)
         .fadeIn(delay: 150.ms, duration: 600.ms),

        const SizedBox(height: 8),

        // Animated Role
        SizedBox(
          height: ResponsiveLayout.isMobile(context) ? 40 : 50,
          child: TypewriterText(
            texts: AppStrings.roleTitles,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontSize: ResponsiveLayout.isMobile(context) ? 24 : 32,
            ),
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

        const SizedBox(height: 24),

        // Tagline
        Text(
          AppStrings.tagline,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: ResponsiveLayout.isMobile(context) ? 16 : 18,
            height: 1.6,
          ),
          textAlign: textAlign,
          maxLines: 3,
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

        const SizedBox(height: 48),

        // CTAs
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildPrimaryCTA(context),
            _buildSecondaryCTA(context),
          ],
        ).animate().scale(delay: 650.ms, duration: 600.ms, curve: Curves.easeOutBack, begin: const Offset(0.9, 0.9))
         .fadeIn(delay: 650.ms, duration: 600.ms),

        const SizedBox(height: 48),

        // Social Links
        const SocialLinksRow().animate().fadeIn(delay: 800.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildPrimaryCTA(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.floatShadow,
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.play_arrow, size: 18),
        label: const Text(AppStrings.btnViewWork),
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.primaryBackground, 
          backgroundColor: AppColors.accentColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSecondaryCTA(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download, size: 18),
      label: const Text(AppStrings.btnDownloadCV),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
