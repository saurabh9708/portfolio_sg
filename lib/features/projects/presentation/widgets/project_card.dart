import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    if (widget.project.status == ProjectStatus.comingSoon) return;
    final uri = Uri.parse(widget.project.liveUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? AppColors.accentColor.withOpacity(0.5) : AppColors.border,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accentColor.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Browser Frame Mockup Image Area
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image with Zoom effect on hover
                      AnimatedScale(
                        scale: _isHovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: widget.project.status == ProjectStatus.comingSoon
                            ? Container(
                                color: AppColors.surfaceColor,
                                child: Center(
                                  child: Icon(Icons.construction, color: AppColors.border, size: 48),
                                ),
                              )
                            : Image.asset(
                                widget.project.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.surfaceColor,
                                  alignment: Alignment.center,
                                  child: const Text('Image Mockup Here', style: TextStyle(color: AppColors.textSecondary)),
                                ),
                              ),
                      ),
                      // Browser Frame Overlay Bar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildWindowDot(Colors.redAccent),
                              const SizedBox(width: 6),
                              _buildWindowDot(Colors.orangeAccent),
                              const SizedBox(width: 6),
                              _buildWindowDot(Colors.greenAccent),
                            ],
                          ),
                        ),
                      ),
                      // Status Badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: widget.project.status == ProjectStatus.live
                                      ? Colors.greenAccent
                                      : Colors.blueAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.project.status == ProjectStatus.live ? 'Live' : 'Coming Soon',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Area
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          widget.project.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tech Stack Strip
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.project.techStack.map((tech) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tech,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.accentColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWindowDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
