import 'package:dots_indicator/dots_indicator.dart';
import 'package:esl/core/services/onboarding_service.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/onboarding/domain/models/onboarding_model.dart';
import 'package:esl/features/onboarding/presentation/widgets/on_board.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int currentIndex = 0;

  List<OnboardingModel> getPages(BuildContext context) {
    return [
      const OnboardingModel(
        title: 'Welcome to Your Marine Academy Journey',
        description:
            "Embark on an exciting educational adventure where you'll learn the fundamentals of marine science, navigation, and maritime operations. Your path to becoming a skilled marine professional starts here.",
        imagePath: 'assets/image1.png',
      ),
      const OnboardingModel(
        title: 'Track Your Academic Progress',
        description:
            'Monitor your grades, course completion, and learning milestones in real-time. Stay on top of your studies with comprehensive progress tracking and performance insights.',
        imagePath: 'assets/image2.png',
      ),
      const OnboardingModel(
        title: 'Access Learning Resources Anywhere',
        description:
            'Connect with your courses, access study materials, and engage with fellow students - all from your mobile device. Your marine academy experience, simplified and accessible.',
        imagePath: 'assets/image3.png',
      ),
    ];
  }

  Future<void> _completeOnboarding() async {
    await markOnboardingAsSeen();
    if (mounted) {
      context.replace(AppConstants.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = getPages(context);

    return Scaffold(
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        controller: pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (currentIndex == pages.length - 1) {
                        _completeOnboarding();
                      } else {
                        pageController.jumpToPage(pages.length - 1);
                      }
                    },
                    child: Text(
                      currentIndex == pages.length - 1 ? 'Done' : 'Skip',
                      style: const TextStyle(
                        color: AppConstants.eslGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                OnBoard(
                  title: pages[index].title,
                  desc: pages[index].description,
                  imagePath: pages[index].imagePath,
                ),

                if (currentIndex == pages.length - 1)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _completeOnboarding,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.eslGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 12.0,
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  DotsIndicator(
                    dotsCount: pages.length,
                    position: currentIndex.toDouble(),
                    decorator: dotsDecorator,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
