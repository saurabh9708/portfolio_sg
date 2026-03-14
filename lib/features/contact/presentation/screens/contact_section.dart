import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_util.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/glass_dropdown_field.dart';

class ContactSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ContactSection({super.key, required this.sectionKey});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String? _selectedProjectType;

  final List<String> _projectTypes = [
    'Mobile App',
    'Web App',
    'Full Stack',
    'Firebase Integration',
    'UI/UX',
    'Other'
  ];

  bool _isSubmitting = false;
  bool _isSuccess = false;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_isVisible) {
      if (mounted) setState(() => _isVisible = true);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      _triggerShake();
      return;
    }

    setState(() {
      _isSubmitting = true;
      _isSuccess = false;
    });

    try {
      // Simulate network delay for testing robustly
      // await Future.delayed(const Duration(seconds: 2));

      await FirebaseFirestore.instance.collection('contact_messages').add({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'projectType': _selectedProjectType,
        'message': _messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _isSuccess = true;
        });
        
        // Clear fields
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        _selectedProjectType = null;
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _triggerShake();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _triggerShake() {
    _shakeController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        key: widget.sectionKey,
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPaddingVDesktop),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520), // Max width centered column
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sectionPaddingHMobile),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.contactTitle,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms),
                  const SizedBox(height: 16),
                  Text(
                    'Have an idea? Let\'s build something great together.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 300.ms, duration: 600.ms),
                  const SizedBox(height: 48),

                  // Form wrapped with Shake animation
                  AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, child) {
                      final sineValue = (10 * _shakeController.value * 3.14159);
                      final offsetX = 10 * (1 - _shakeController.value) * (sineValue).sin();
                      return Transform.translate(
                        offset: Offset(offsetX, 0),
                        child: child,
                      );
                    },
                    child: _isSuccess ? _buildSuccessMessage() : _buildForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          GlassTextField(
            labelText: 'Full Name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.trim().length < 2) {
                return 'Please enter your name (min 2 chars)';
              }
              return null;
            },
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 400.ms).slideX(begin: -0.1),

          GlassTextField(
            labelText: 'Email Address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 500.ms).slideX(begin: 0.1),

          GlassDropdownField(
            labelText: 'Project Type',
            value: _selectedProjectType,
            items: _projectTypes,
            onChanged: (val) {
              setState(() => _selectedProjectType = val);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a project type';
              }
              return null;
            },
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 600.ms).slideX(begin: -0.1),

          GlassTextField(
            labelText: 'Message',
            controller: _messageController,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.trim().length < 20) {
                return 'Please enter a message (min 20 chars)';
              }
              return null;
            },
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 700.ms).slideX(begin: 0.1),

          const SizedBox(height: 16),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.surfaceColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.surfaceColor,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Send Message →',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
            ),
          ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 800.ms).scaleXY(begin: 0.9, end: 1),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.primaryColor,
            size: 80,
          ).animate().scale(delay: 200.ms, curve: Curves.elasticOut),
          const SizedBox(height: 24),
          Text(
            'Message Sent!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 8),
          Text(
            'I\'ll get back to you within 24 hours.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {
              setState(() => _isSuccess = false);
            },
            child: const Text(
              'Send another message',
              style: TextStyle(color: AppColors.accentColor),
            ),
          ).animate().fadeIn(delay: 800.ms),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}
