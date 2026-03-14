import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLink {
  final String tooltip;
  final String url;
  final IconData? iconData; // Use iconData OR svgAsset
  final String? svgAsset;

  const SocialLink({
    required this.tooltip,
    required this.url,
    this.iconData,
    this.svgAsset,
  });
}

class SocialLinksRow extends StatelessWidget {
  final bool vertical;

  const SocialLinksRow({super.key, this.vertical = false});

  static const List<SocialLink> links = [
    SocialLink(
      tooltip: 'GitHub',
      url: 'https://github.com/saurabh9708',
      iconData: Icons.code, // Placeholder for GitHub icon if font awesome isn't used
    ),
    SocialLink(
      tooltip: 'LinkedIn',
      url: 'https://www.linkedin.com/in/saurabh-java-developer/',
      iconData: Icons.work, // Placeholder
    ),
    SocialLink(
      tooltip: 'Upwork',
      url: 'https://www.upwork.com/freelancers/~017506cb1a548daf69',
      svgAsset: 'assets/icons/upwork.svg',
    ),
    SocialLink(
      tooltip: 'Fiverr',
      url: 'https://www.fiverr.com/s/o8N8Z74',
      svgAsset: 'assets/icons/fiverr.svg',
    ),
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = links.map((link) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: vertical ? 0 : 8.0,
          vertical: vertical ? 8.0 : 0,
        ),
        child: _buildSocialIcon(context, link),
      );
    }).toList();

    return vertical
        ? Column(mainAxisSize: MainAxisSize.min, children: children)
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  Widget _buildSocialIcon(BuildContext context, SocialLink link) {
    return Tooltip(
      message: link.tooltip,
      decoration: BoxDecoration(color: AppColors.surfaceColor, borderRadius: BorderRadius.circular(4)),
      textStyle: const TextStyle(color: AppColors.accentColor, fontSize: 12),
      child: InkWell(
        onTap: () => _launchUrl(link.url),
        borderRadius: BorderRadius.circular(8),
        hoverColor: Colors.white.withOpacity(0.05),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: link.svgAsset != null
                ? SvgPicture.asset(
                    link.svgAsset!,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                  )
                : Icon(
                    link.iconData,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }
}
