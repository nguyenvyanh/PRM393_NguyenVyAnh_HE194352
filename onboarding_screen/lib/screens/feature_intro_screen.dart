import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/onboarding_data.dart';
import '../widgets/feature_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/page_indicator.dart';

class FeatureIntroScreen extends StatefulWidget {
  const FeatureIntroScreen({super.key});

  @override
  State<FeatureIntroScreen> createState() => _FeatureIntroScreenState();
}

class _FeatureIntroScreenState extends State<FeatureIntroScreen> {
  final PageController pageController = PageController(
    viewportFraction: 0.72,
  );

  int currentIndex = 0;

  void finishOnboarding() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hoàn tất onboarding'),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(
          'GIỚI THIỆU TÍNH NĂNG',
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 56),
          SizedBox(
            height: 290,
            child: PageView.builder(
              controller: pageController,
              itemCount: onboardingFeatures.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return FeatureCard(
                  feature: onboardingFeatures[index],
                  isActive: index == currentIndex,
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          PageIndicator(
            itemCount: onboardingFeatures.length,
            currentIndex: currentIndex,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 28,
            ),
            child: GradientButton(
              title: 'BẮT ĐẦU',
              onPressed: finishOnboarding,
            ),
          ),
        ],
      ),
    );
  }
}